//
//  InitialSettingsPageVM.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/11/23.
//

import UIKit
import RxSwift
import RxCocoa

class InitialSettingsPageVM {
    //MARK: - properties
    private let bag = DisposeBag()
    
    private let pages = BehaviorRelay<[UIViewController]>(value: [])
    let currentPage = BehaviorRelay<Int>(value: 0)
    
    //MARK: - lifecycle
    init() {
        setupPages()
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
            
        let page1 = DepartureSettingVC(viewModel: departureVM)
        let page2 = DestinationSettingVC(viewModel: destinationVM)
        let page3 = DayOfWeekSettingVC(viewModel: dayOfWeekVM)
        let page4 = TransportationSettingVC(viewModel: transportationVM)
        let page5 = ArrivalTimeSettingVC(viewModel: arrivalTimeVM)
        
        pages.accept([page1, page2, page3, page4, page5])
        
        dayOfWeekVM.moveToNext
            .subscribe(onNext: { [unowned self] selectedDays in
                guard selectedDays.isEmpty == false else { return }
                print("선택한 요일들 : \(selectedDays)")
                goToNextPage()
            })
            .disposed(by: bag)
        
        transportationVM.moveToNext
            .subscribe { [unowned self] (transportation, index) in
                print("선택한 교통수단 : \(transportation)")
                goToNextPage()
            }
            .disposed(by: bag)
        
        arrivalTimeVM.moveToNext
            .subscribe { date in
                print("선택한 시간 : \(date)")
                
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                    let sceneDelegate = windowScene.delegate as? SceneDelegate {

                    sceneDelegate.window?.rootViewController = BaseTabBarController()

                    if let window = sceneDelegate.window {
                        UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: { })
                    }
                }
            }
            .disposed(by: bag)
    }
    
    func viewControllerForPage(_ page: Int) -> UIViewController {
        return pages.value[page]
    }
    
    func goToNextPage() {
        let CURRENT = currentPage.value
        currentPage.accept(CURRENT + 1)
    }
}
