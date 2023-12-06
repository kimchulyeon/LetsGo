//
//  DayOfWeekSettingVM.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/6/23.
//

import Foundation
import RxSwift
import RxRelay

class DayOfWeekSettingVM {
    //MARK: - properties
    private let bag = DisposeBag()
    
    struct Input {
        typealias Index = Int
        let dayButtonTapped: Observable<(DayOfWeek, Index)>
        let nextButtonTapped: Observable<Void>
    }
    
    struct Output {
        typealias Index = Int
        let selectedDays = BehaviorRelay<[(DayOfWeek, Index)]>(value: [])
        let moveToNext = PublishRelay<Void>()
    }
    
    //MARK: - method
    func transform(input: Input) -> Output {
        let output = Output()
        
        input.dayButtonTapped
            .subscribe { dayAndIndex in
                var selectedDaysList = output.selectedDays.value
                
                if selectedDaysList.contains(where: { $0 == dayAndIndex }) {
                    selectedDaysList.removeAll(where: { $0 == dayAndIndex })
                }
                else {
                    selectedDaysList.append(dayAndIndex)
                }
                output.selectedDays.accept(selectedDaysList)
            }
            .disposed(by: bag)
        
        input.nextButtonTapped
            .subscribe { _ in
                output.moveToNext.accept(())
            }
            .disposed(by: bag)
        
        return output
    }
}

