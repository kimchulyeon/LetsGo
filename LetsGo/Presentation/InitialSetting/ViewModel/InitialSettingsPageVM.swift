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
    
    private var initalAlarm = Alarm(alarmName: "",
                                    transportationType: .none,
                                    departurePlaceName: "",
                                    destinationPlaceName: "",
                                    departureLocation: nil,
                                    destinationLocation: nil,
                                    days: [],
                                    arriveHour: 0,
                                    arriveMinute: 0,
                                    floatTime: 0)
    private let pages = BehaviorRelay<[UIViewController]>(value: [])
    let currentPage = BehaviorRelay<Int>(value: 0)
    
    //MARK: - lifecycle
    init(initialSettingUseCase: InitialSettingUseCaseProtocol) {
        self.initialSettingUseCase = initialSettingUseCase
        setupPages()
        calculateAlarmTime()
    }
    
    //MARK: - method
    private func setupPages() {
        let locationSearchDatasource = LocationSearchDatasource()
        let locationSearchRepository = LocationSearchRepository(locationSearchdatasource: locationSearchDatasource)
        let locationUseCase = LocationUseCase(locationRepository: locationSearchRepository)
        
        let departureVM = DepartureSettingVM(locationUseCase: locationUseCase)
        let destinationVM = DestinationSettingVM(locationUseCase: locationUseCase)
        let dayOfWeekVM = DayOfWeekSettingVM()
        let transportationVM = TransportationSettingVM()
        let arrivalTimeVM = ArrivalTimeSettingVM()
        let alarmNameVM = AlarmNameSettingVM()
            
        let page1 = DepartureSettingVC(viewModel: departureVM)
        let page2 = DestinationSettingVC(viewModel: destinationVM)
        let page3 = DayOfWeekSettingVC(viewModel: dayOfWeekVM)
        let page4 = TransportationSettingVC(viewModel: transportationVM)
        let page5 = ArrivalTimeSettingVC(viewModel: arrivalTimeVM)
        let page6 = AlarmNameSettingVC(viewModel: alarmNameVM)
        
        pages.accept([page1, page2, page3, page4, page5, page6])
        
        departureVM.selectedLocation
            .withUnretained(self)
            .subscribe { (self, location) in
                self.initalAlarm.departureLocation = location
                print("선택한 출발지 : \(location)")
            }
            .disposed(by: bag)
        
        destinationVM.selectedLocation
            .withUnretained(self)
            .subscribe { (self, location) in
                self.initalAlarm.destinationLocation = location
                print("선택한 도착지 : \(location)")
            }
            .disposed(by: bag)
        
        dayOfWeekVM.moveToNext
            .withUnretained(self)
            .subscribe { (self, selectedDaysTupleArray) in
                guard selectedDaysTupleArray.isEmpty == false else { return }
                let days = selectedDaysTupleArray.map { (day, index) in day }
                self.initalAlarm.days = days
                print("선택한 요일들 : \(days)")
                self.goToNextPage()
            }
            .disposed(by: bag)
        
        transportationVM.moveToNext
            .withUnretained(self)
            .subscribe { (self, transportationTuple) in
                let transportation = transportationTuple.0
                self.initalAlarm.transportationType = transportation
                print("선택한 교통수단 : \(transportation)")
                self.goToNextPage()
            }
            .disposed(by: bag)
        
        arrivalTimeVM.moveToNext
            .withUnretained(self)
            .subscribe { (self, dateStr) in
                let components = dateStr.split(separator: ":").map(String.init)
                if components.count == 2 {
                    self.initalAlarm.arriveHour = Int(components[0]) ?? 0
                    self.initalAlarm.arriveMinute = Int(components[1]) ?? 0
                    print("선택한 시 : \(Int(components[0]) ?? 0)")
                    print("선택한 분 : \(Int(components[1]) ?? 0)")
                }
                self.goToNextPage()
            }
            .disposed(by: bag)
        
        alarmNameVM.moveToNext
            .withUnretained(self)
            .subscribe { (self, name) in
                print("알람 이름 : \(name)")
                self.initalAlarm.alarmName = name
                self.moveToHomeScene()
            }
            .disposed(by: bag)
    }
    
    private func calculateAlarmTime() {
        initialSettingUseCase.calculateAlarmTime()
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
