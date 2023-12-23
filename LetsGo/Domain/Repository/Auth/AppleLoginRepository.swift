//
//  AppleLoginRepository.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/17/23.
//

import UIKit
import RxSwift
import FirebaseAuth

class AppleLoginRepository: AppleLoginRepositoryProtocol {
    //MARK: - properties
    private let bag = DisposeBag()
    private let dataSource: UserDefaultsDatasourceProtocol
    
    //MARK: - lifecycle
    init(dataSource: UserDefaultsDatasourceProtocol) {
        self.dataSource = dataSource
    }
    
    //MARK: - method
    func authenticate(at vc: UIViewController?) -> Observable<User> {
        guard let vc = vc else { return Observable.empty() }
        AppleService.shared.startSignInWithAppleFlow(view: vc)
        return AppleService.shared.appleUserDataObservable
    }
    
    func saveCredential(credential: AuthCredential) {
        // X - credential 저장이 아니라 사용자 정보를 UserDefaults에 저장해서 로그인으로 활용
        dataSource.saveCredential(credential: credential)
    }
}
