//
//  AppleLoginRepository.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/17/23.
//

import UIKit
import RxSwift

class AppleLoginRepository: AppleLoginRepositoryProtocol {
    private let bag = DisposeBag()
    
    func authenticate(at vc: UIViewController?) -> Observable<Void> {
        guard let vc = vc else { return Observable.empty() }
        AppleService.shared.startSignInWithAppleFlow(view: vc)
        
        AppleService.shared.appleOAuthCredentialObservable
            .subscribe { credential in
                print(credential)
                
            }
            .disposed(by: bag)
        
        return Observable.just(())
    }
}
