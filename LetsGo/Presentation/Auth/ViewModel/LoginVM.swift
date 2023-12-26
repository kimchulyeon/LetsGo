//
//  LoginVM.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/15/23.
//

import UIKit
import RxSwift
import RxCocoa
import FirebaseAuth

class LoginVM {
    //MARK: - properties
    private let bag = DisposeBag()
    private let loginUseCase: LoginUseCaseProtocol
    
    struct Input {
        let appleLoginButtonTapped: Observable<Void>
        let googleLoginButtonTapped: Observable<Void>
    }
    
    struct Output {
        let loginResult = PublishSubject<Bool>()
        let isLoading = PublishSubject<Bool>()
    }

    //MARK: - lifecycle
    init(loginUseCase: LoginUseCaseProtocol) {
        self.loginUseCase = loginUseCase
    }
    

    //MARK: - method
    func transform(input: Input) -> Output {
        let output = Output()
        
        input.appleLoginButtonTapped
            .withUnretained(self)
            .flatMapLatest { (self, _) in
                output.isLoading.onNext(true)
                return self.loginUseCase.oauthLogin(type: .Apple)
            }
            .subscribe { result in
                output.isLoading.onNext(false)
                
                switch result.element {
                case .success(let user):
                    self.loginUseCase.saveUserForLogin(user)
                    output.loginResult.onNext(true)
                case .fail: 
                    output.loginResult.onNext(false)
                default: break
                }
            }
            .disposed(by: bag)
            
        
        input.googleLoginButtonTapped
            .withUnretained(self)
            .flatMapLatest { (self, _) in
                output.isLoading.onNext(true)
                return self.loginUseCase.oauthLogin(type: .Google)
            }
            .subscribe { result in
                output.isLoading.onNext(false)
                
                switch result.element {
                case .success(let user):
                    self.loginUseCase.saveUserForLogin(user)
                    output.loginResult.onNext(true)
                case .fail: 
                    output.loginResult.onNext(false)
                default: break
                }
            }
            .disposed(by: bag)
        return output
    }
}
