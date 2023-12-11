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
            .map({ date in
                DateFormatterService.formatDateToTime(date: date)
            })
            .subscribe(onNext: { dateString in
                print(" 선택한 시간 : \(dateString) ")
            })
            .disposed(by: bag)
        
        input.nextButtonTapped
            .subscribe { _ in
                output.moveToNext.accept(())
            }
            .disposed(by: bag)
        
        return output
    }
}
