//
//  DepartureSettingVM.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/7/23.
//

import Foundation
import RxSwift
import RxCocoa

enum SearchType {
    case keyword
    case address
}

class DepartureSettingVM {
    //MARK: - properties
    private let locationUseCase = LocationUseCase()
    private let bag = DisposeBag()
    
    struct Input {
        let inputTextField: Observable<String>
        let searchTypeButtonTapped: Observable<SearchType>
    }
    
    struct Output {
        let searchedLocationLists = BehaviorRelay<[Location]>(value: [])
        let buttonType = BehaviorRelay<SearchType>(value: .keyword)
    }
    
    //MARK: - method
    func transform(input: Input) -> Output {
        let output = Output()
        
        input.inputTextField
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .flatMapLatest({ [weak self] query -> Observable<[Location]> in
                print("입력 검색어 : \(query)")
                guard let weakSelf = self, query.isEmpty == false else { return Observable.empty() }
                return weakSelf.locationUseCase.locationSearch(query: query)
            })
            .subscribe(onNext: { locations in
                output.searchedLocationLists.accept(locations)
            })
            .disposed(by: bag)
        
        input.searchTypeButtonTapped
            .subscribe { type in
                output.buttonType.accept(type)
            }
            .disposed(by: bag)
        
        return output
    }
}
