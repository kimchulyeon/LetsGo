//
//  AlarmNameSettingVM.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/14/23.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

class AlarmNameSettingVM {
    //MARK: - properties
    private let bag = DisposeBag()
    
    let moveToNext = PublishRelay<String>()
    
    struct Input {
        let nameBeInput: Observable<String?>
        let nextButtonTapped: Observable<Void>
    }
    
    struct Output {
        let alarmName = BehaviorRelay<String>(value: "")
    }
    
    //MARK: - lifecycle
    
    //MARK: - method
    func transform(input: Input) -> Output {
        let output = Output()
        
        input.nameBeInput
            .subscribe { text in
                guard let text = text else { return }
                output.alarmName.accept(text)
            }
            .disposed(by: bag)
        
        input.nextButtonTapped
            .withUnretained(self)
            .subscribe { (self, _) in
                self.moveToNext.accept(output.alarmName.value)
            }
            .disposed(by: bag)
        
        return output
    }
}
