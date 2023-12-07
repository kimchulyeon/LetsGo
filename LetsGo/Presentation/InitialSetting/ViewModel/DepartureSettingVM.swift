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
    private let locationUseCase: LocationUseCaseProtocol
    private let bag = DisposeBag()
    
    struct Input {
        let inputTextField: Observable<String>
        let searchTypeButtonTapped: Observable<SearchType>
    }
    
    struct Output {
        let searchedLocationLists = BehaviorRelay<[Location]>(value: [])
        let buttonType = BehaviorRelay<SearchType>(value: .keyword)
    }
    
    // MARK: - lifecycle
    init(locationUseCase: LocationUseCaseProtocol) {
        self.locationUseCase = locationUseCase
    }
    
    //MARK: - method
    func transform(input: Input) -> Output {
        let output = Output()
        
        input.inputTextField
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .flatMapLatest({ [weak self] query -> Observable<[Location]> in
                guard let weakSelf = self, query.isEmpty == false else { return Observable.empty() }
                let currentSearchType = output.buttonType.value
                print("입력 검색어 : \(query)")
                print("버튼 타입 : \(currentSearchType)")
                return weakSelf.locationUseCase.locationSearch(type: currentSearchType, query: query)
            })
            .subscribe(onNext: { locations in
                output.searchedLocationLists.accept(locations)
            })
            .disposed(by: bag)
        
        input.searchTypeButtonTapped
            .subscribe { type in
                output.searchedLocationLists.accept([])
                output.buttonType.accept(type)
            }
            .disposed(by: bag)
        
        return output
    }
}
