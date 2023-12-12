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
    
    let moveToNext = PublishRelay<(Transportation, Int)>()
    
    struct Input {
        let transportationButtonTapped: Observable<(Transportation, Int)>
        let nextButtonTapped: Observable<Void>
    }
    
    struct Output {
        let selectedTransportation = BehaviorRelay<(Transportation, Int)>(value: (.none, 404))
    }
    
    //MARK: - method
    func transform(input: Input) -> Output {
        let output = Output()
        
        input.transportationButtonTapped
            .subscribe { (transportation) in
                output.selectedTransportation.accept(transportation)
            }
            .disposed(by: bag)
        
        input.nextButtonTapped
            .subscribe { [unowned self] _ in
                moveToNext.accept(output.selectedTransportation.value)
            }
            .disposed(by: bag)
        
        return output
    }
}
