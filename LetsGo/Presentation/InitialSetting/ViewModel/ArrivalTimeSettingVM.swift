//
//  ArrivalTimeSettingVM.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/11/23.
//

import Foundation
import RxSwift
import RxCocoa

class ArrivalTimeSettingVM {
    //MARK: - properties
    private let bag = DisposeBag()
    
    let selectedTime = BehaviorRelay<String>(value: "")
    let moveToNext = PublishRelay<String>()
    
    struct Input {
        let timeSelected: Observable<Date>
        let nextButtonTapped: Observable<Void>
    }
    
    struct Output {
        let moveToNext = PublishRelay<Void>()
    }
    
    //MARK: - lifecylce
    
    //MARK: - method
    func transform(input: Input) -> Output {
        let output = Output()
        
        input.timeSelected
            .map({ [unowned self] date in
                let dateStr = DateFormatterService.formatDateToTime(date: date)
                selectedTime.accept(dateStr)
                
                return dateStr
            })
            .subscribe()
            .disposed(by: bag)
        
        input.nextButtonTapped
            .map { [unowned self] _ in
                return selectedTime.value
            }
            .subscribe(onNext: { [unowned self] timeStr in
                moveToNext.accept(timeStr)
            })
            .disposed(by: bag)
        
        return output
    }
}
