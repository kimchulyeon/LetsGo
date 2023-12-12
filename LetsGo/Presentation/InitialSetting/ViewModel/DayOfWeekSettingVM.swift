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
    typealias Index = Int
    
    private let bag = DisposeBag()
    
    let moveToNext = PublishRelay<[(DayOfWeek, Index)]>()
    
    struct Input {
        let dayButtonTapped: Observable<(DayOfWeek, Index)>
        let nextButtonTapped: Observable<Void>
    }
    
    struct Output {
        typealias Index = Int
        let selectedDays = BehaviorRelay<[(DayOfWeek, Index)]>(value: [])
    }
    
    //MARK: - method
    func transform(input: Input) -> Output {
        let output = Output()
        
        input.dayButtonTapped
            .subscribe { daysAndIndex in
                var selectedDaysList = output.selectedDays.value
                
                if selectedDaysList.contains(where: { $0 == daysAndIndex }) {
                    selectedDaysList.removeAll(where: { $0 == daysAndIndex })
                }
                else {
                    selectedDaysList.append(daysAndIndex)
                }
                output.selectedDays.accept(selectedDaysList)
            }
            .disposed(by: bag)
        
        input.nextButtonTapped
            .subscribe { [unowned self] _ in
                moveToNext.accept(output.selectedDays.value)
            }
            .disposed(by: bag)
        
        return output
    }
}

