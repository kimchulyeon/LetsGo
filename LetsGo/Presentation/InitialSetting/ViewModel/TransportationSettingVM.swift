//
//  TransportationSettingVM.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/5/23.
//

import Foundation
import RxSwift
import RxRelay

class TransportationSettingVM {
    //MARK: - properties
    private let bag = DisposeBag()
    
    struct Input {
        let selectButtonTapped: Observable<Int>
        let nextButtonTapped: Observable<Void>
    }
    
    struct Output {
        let selectedButtonIndex = BehaviorRelay<Int>(value: 404)
        let moveToNext = PublishRelay<Void>()
    }
    
    //MARK: - method
    func transform(input: Input) -> Output {
        let output = Output()
        
        input.selectButtonTapped
            .subscribe { index in
                output.selectedButtonIndex.accept(index)
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
