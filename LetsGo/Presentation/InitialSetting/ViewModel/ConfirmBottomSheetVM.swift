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
        let dismissBottomSheet = BehaviorRelay<Location?>(value: nil)
    }
    
    //MARK: - lifecycle
    
    //MARK: - method
    func transform(input: Input) -> Output {
        let output = Output()
        
        input.cancelButtonTapped
            .subscribe { _ in
                output.dismissBottomSheet.accept(nil)
            }
            .disposed(by: bag)
        
        input.confirmButtonTapped
            .flatMap({ [unowned self] _ in
                selectedLocation.asObserver()
            })
            .subscribe { location in
                output.dismissBottomSheet.accept(location)
            }
            .disposed(by: bag)

        
        return output
    }
}
