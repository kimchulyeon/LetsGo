//
//  AlarmListVM.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/12/23.
//

import Foundation
import RxSwift
import RxRelay
import CoreLocation
import RxCocoa

class AlarmListVM {
    //MARK: - properties
    private let bag = DisposeBag()
    
    struct Input {
        let addButtonTapped: Observable<Void>
        let alarmTapped: Driver<Alarm>
//        let deleteButtonTapped: Driver<Alarm>
    }
    
    struct Output {
        let alarmList = BehaviorSubject<[Alarm]>(value: Test.alarmList)
        let addButtonTapped = PublishRelay<Void>()
    }
    
    //MARK: - lifecycle
    
    //MARK: - method
    func transform(input: Input) -> Output {
        let output = Output()
        
        input.addButtonTapped
            .subscribe { _ in
                output.addButtonTapped.accept(())
            }
            .disposed(by: bag)
        
        input.alarmTapped
            .drive { alarm in
                print(alarm)
            }
        
        return output
    }
}
