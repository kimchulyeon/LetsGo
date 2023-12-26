//
//  LoginUseCase.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/17/23.
//

import UIKit
import RxSwift
import FirebaseAuth

class LoginUseCase: LoginUseCaseProtocol {
    // MARK: - properties
    private let appleRepository: AppleLoginRepositoryProtocol
    private let googleRepository: GoogleLoginRepositoryProtocol
    private let sceneRepositroy: SceneRepositoryProtocol
    private let firebaseRepository: FirebaseRepositoryProtocol
    private let firestoreUserRepository: FirestoreUserRepositoryProtocol
    private let userRepository: UserRepositoryProtocol

    // MARK: - lifecycle
    init(appleRepository: AppleLoginRepositoryProtocol,
         googleRepository: GoogleLoginRepositoryProtocol,
         sceneRepository: SceneRepositoryProtocol,
         firebaseRepository: FirebaseRepositoryProtocol,
         firestoreUserRepository: FirestoreUserRepositoryProtocol,
         userRepository: UserRepositoryProtocol) {

        self.appleRepository = appleRepository
        self.googleRepository = googleRepository
        self.sceneRepositroy = sceneRepository
        self.firebaseRepository = firebaseRepository
        self.firestoreUserRepository = firestoreUserRepository
        self.userRepository = userRepository
    }


    // MARK: - method
    // loginVC에서 로그인 진행 => 파이어베이스 로그인 => uid로 DB 조회해서 신규 유저/가입유저 체크
    func oauthLogin(type: ProviderType) -> Observable<LoginResultWithUserData> {
        return sceneRepositroy.getTopViewController()
            .withUnretained(self)
            .flatMapLatest { (self, vc) in
                switch type {
                case .Apple: self.appleRepository.authenticate(at: vc)
                case .Google: self.googleRepository.authenticate(at: vc)
                }
            }
            .withUnretained(self)
            .flatMap { (self, updatedUserData) in
                self.firebaseRepository.login(with: updatedUserData)
            }
            .withUnretained(self)
            .flatMap { (self, user) in
                self.checkUserAlreadyRegistered(with: user)
                    .withUnretained(self)
                    .flatMap { (self, docId) -> Observable<LoginResultWithUserData> in
                        guard let user = user else { return Observable.just(LoginResultWithUserData.fail(LoginError.oauthLoginFailed(""))) }
                        
                        if let docId = docId {
                            // 이미 가입한 유저
                            return self.firestoreUserRepository.getUser(with: docId)
                        } else {
                            // 신규 유저
                            return self.firestoreUserRepository.saveUser(user)
                        }
                    }
            }
    }
    
    func saveUserForLogin(_ user: User) {
        userRepository.saveUser(user)
    }


    // MARK: - helper
    private func checkUserAlreadyRegistered(with user: User?) -> Observable<String?> {
        let uid = user?.uid
        return self.firestoreUserRepository.checkUser(with: uid)
    }
}
