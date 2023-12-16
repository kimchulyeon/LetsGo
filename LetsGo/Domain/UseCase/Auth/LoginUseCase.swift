//
//  LoginUseCase.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/17/23.
//

import UIKit
import RxSwift

class LoginUseCase: LoginUseCaseProtocol {
    // MARK: - properties
    private let appleRepository: AppleLoginRepositoryProtocol
    private let googleRepository: GoogleLoginRepositoryProtocol
    private let sceneRepositroy: SceneRepositoryProtocol
    
    // MARK: - lifecycle
    init(appleRepository: AppleLoginRepositoryProtocol, googleRepository: GoogleLoginRepositoryProtocol, sceneRepository: SceneRepositoryProtocol) {
        self.appleRepository = appleRepository
        self.googleRepository = googleRepository
        self.sceneRepositroy = sceneRepository
    }
    
    
    // MARK: - method
    func loginWithApple() -> Observable<Void> {
        return sceneRepositroy.getTopViewController()
            .withUnretained(self)
            .flatMapLatest { (self, vc) in
                self.appleRepository.authenticate(at: vc)
            }
    }
    
    func loginWithGoogle() {
        googleRepository.authenticate()
    }
}