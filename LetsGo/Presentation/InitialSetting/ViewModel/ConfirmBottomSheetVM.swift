//
//  ConfirmBottomSheetVM.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/8/23.
//

import Foundation
import RxSwift
import RxRelay

class ConfirmBottomSheetVM {
    //MARK: - properties
    private let bag = DisposeBag()
    
    let selectedLocation = BehaviorSubject<Location?>(value: nil) 
    
    struct Input {
        let cancelButtonTapped: Observable<Void>
        let confirmButtonTapped: Observable<Void>
    }
    
    struct Output {
        let dismissBottomSheet = PublishRelay<Void>()
    }
    
    //MARK: - lifecycle
    
    //MARK: - method
    func transform(input: Input) -> Output {
        let output = Output()
        
        input.cancelButtonTapped
            .subscribe { _ in
                output.dismissBottomSheet.accept(())
            }
            .disposed(by: bag)
        
        input.confirmButtonTapped
            .withLatestFrom(selectedLocation)
            .subscribe { location in
                print("선택한 위치 : \(location)")
                output.dismissBottomSheet.accept(())
            }
            .disposed(by: bag)

        
        return output
    }
}
