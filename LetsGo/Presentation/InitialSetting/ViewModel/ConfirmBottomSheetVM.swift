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
    
    let selectedLocation = PublishSubject<Location>()
    
    struct Input {
        let cancelButtonTapped: Observable<Void>
        let confirmButtonTapped: Observable<Location>
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
            .subscribe { location in
                print("네 맞이요! : \(location)")
            }
            .disposed(by: bag)
        
        return output
    }
}
