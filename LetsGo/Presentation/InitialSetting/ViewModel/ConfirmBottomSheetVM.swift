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
            .subscribe { [weak self] _ in
                #warning("확인 버튼 눌렀을 때 선택된 장소 정보 가지고 있는지? 선택된 장보 정소 보관 확인")
                print(self?.selectedLocation)
            }
            .disposed(by: bag)
        
        return output
    }
}
