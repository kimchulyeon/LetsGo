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
        let transportationButtonTapped: Observable<(Transportation, Int)>
        let nextButtonTapped: Observable<Void>
    }
    
    struct Output {
        let selectedTransportation = BehaviorRelay<(Transportation, Int)>(value: (.none, 404))
        let moveToNext = PublishRelay<Void>()
    }
    
    //MARK: - method
    func transform(input: Input) -> Output {
        let output = Output()
        
        input.transportationButtonTapped
            .subscribe { (transportation) in
                print("\n📂파일 : \(#file)\n📏줄 : \(#line)\n🚀함수 : \(#function)\n✅ 선택된 교통수단 : \(transportation) \n")
                output.selectedTransportation.accept(transportation)
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
