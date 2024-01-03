//
//  InitialSettingsPageVM.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/11/23.
//

import UIKit
import RxSwift
import RxCocoa
import CoreLocation

class InitialSettingsPageVM {
    //MARK: - properties
    private let bag = DisposeBag()
    private let initialSettingUseCase: InitialSettingUseCaseProtocol
    private var locationSearchDatasource: LocationSearchDatasourceProtocol?
    private var locationSearchRepository: LocationSearchRepositoryProtocol?
    private var locationUseCase: LocationUseCaseProtocol?
    private var departureVM: DepartureSettingVM?
    private var destinationVM: DestinationSettingVM?
    private var dayOfWeekVM: DayOfWeekSettingVM?
    private var transportationVM: TransportationSettingVM?
    private var arrivalTimeVM: ArrivalTimeSettingVM?
    private var alarmNameVM: AlarmNameSettingVM?
    
    private var initialAlarm = Alarm(alarmName: "",
                                    transportationType: .none,
                                    departurePlaceName: "",
                                    destinationPlaceName: "",
                                    departureLocation: nil,
                                    destinationLocation: nil,
                                    days: [],
                                    arriveHour: 0,
                                    arriveMinute: 0,
                                    floatTime: 0)
    private var initialAlarmObservable: Observable<Alarm> {
        print(initialAlarm)
        return Observable.just(initialAlarm)
    }
    private var isInitialAlarmSettingFinish = BehaviorSubject<Bool>(value: false)
    
    private let pages = BehaviorRelay<[UIViewController]>(value: [])
    let currentPage = BehaviorRelay<Int>(value: 0)
    
    //MARK: - lifecycle
    init(initialSettingUseCase: InitialSettingUseCaseProtocol) {
        self.initialSettingUseCase = initialSettingUseCase
        setupPages()
        setupInitialAlarm()
    }
    
    //MARK: - method
    private func setupPages() {
        locationSearchDatasource = LocationSearchDatasource()
        locationSearchRepository = LocationSearchRepository(locationSearchdatasource: locationSearchDatasource)
        locationUseCase = LocationUseCase(locationRepository: locationSearchRepository)
        
        departureVM = DepartureSettingVM(locationUseCase: locationUseCase!)
        destinationVM = DestinationSettingVM(locationUseCase: locationUseCase!)
        dayOfWeekVM = DayOfWeekSettingVM()
        transportationVM = TransportationSettingVM()
        arrivalTimeVM = ArrivalTimeSettingVM()
        alarmNameVM = AlarmNameSettingVM()
        
        let page1 = DepartureSettingVC(viewModel: departureVM!)
        let page2 = DestinationSettingVC(viewModel: destinationVM!)
        let page3 = DayOfWeekSettingVC(viewModel: dayOfWeekVM!)
        let page4 = TransportationSettingVC(viewModel: transportationVM!)
        let page5 = ArrivalTimeSettingVC(viewModel: arrivalTimeVM!)
        let page6 = AlarmNameSettingVC(viewModel: alarmNameVM!)
        
        pages.accept([page1, page2, page3, page4, page5, page6])
    }
    
    private func setupInitialAlarm() {
        departureVM?.selectedLocation
            .withUnretained(self)
            .subscribe { (self, location) in
                self.initialAlarm.departureLocation = location
            }
            .disposed(by: bag)
        
        destinationVM?.selectedLocation
            .withUnretained(self)
            .subscribe { (self, location) in
                self.initialAlarm.destinationLocation = location
            }
            .disposed(by: bag)
        
        dayOfWeekVM?.moveToNext
            .withUnretained(self)
            .subscribe { (self, selectedDaysTupleArray) in
                guard selectedDaysTupleArray.isEmpty == false else { return }
                let days = selectedDaysTupleArray.map { (day, index) in day }
                self.initialAlarm.days = days
                self.goToNextPage()
            }
            .disposed(by: bag)
        
        transportationVM?.moveToNext
            .withUnretained(self)
            .subscribe { (self, transportationTuple) in
                let transportation = transportationTuple.0
                self.initialAlarm.transportationType = transportation
                self.goToNextPage()
            }
            .disposed(by: bag)
        
        arrivalTimeVM?.moveToNext
            .withUnretained(self)
            .subscribe { (self, dateStr) in
                let components = dateStr.split(separator: ":").map(String.init)
                if components.count == 2 {
                    self.initialAlarm.arriveHour = Int(components[0]) ?? 0
                    self.initialAlarm.arriveMinute = Int(components[1]) ?? 0
                }
                self.goToNextPage()
            }
            .disposed(by: bag)
        
        alarmNameVM?.moveToNext
            .withUnretained(self)
            .subscribe { (self, name) in
                self.initialAlarm.alarmName = name
                self.isInitialAlarmSettingFinish.onNext(true)
//                self.calculateAlarmTime(with: self.initialAlarm)
//                self.moveToHomeScene()
            }
            .disposed(by: bag)
        
        isInitialAlarmSettingFinish
            .subscribe { isFinish in
                if isFinish == false { return }
                
            }
            .disposed(by: bag)
    }
    
    private func calculateAlarmTime(with alarm: Alarm) {
        initialSettingUseCase.calculateAlarmTime(with: alarm)
    }
    
    func viewControllerForPage(_ page: Int) -> UIViewController {
        return pages.value[page]
    }
    
    func goToNextPage() {
        let CURRENT = currentPage.value
        currentPage.accept(CURRENT + 1)
    }
    
    private func moveToHomeScene() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate {

            sceneDelegate.window?.rootViewController = BaseTabBarController()

            if let window = sceneDelegate.window {
                UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: { })
            }
        }
    }
}
