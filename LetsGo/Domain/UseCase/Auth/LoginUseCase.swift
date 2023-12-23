//
//  LoginUseCase.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/17/23.
//

import UIKit
import RxSwift
import FirebaseAuth

#warning("옮겨야함")
enum ProviderType: String {
    case Apple = "apple"
    case Google = "google"
}

enum LoginError: Error {
    case appleLoginFailed(String)
    case firebaseLoginFailed(String)
    case userFetchFailed(String)
    case userSaveFailed(String)
}

struct User {
    var uid: String?
    var docId: String?
    let username: String
    let email: String?
    let credential: OAuthCredential?
    let provider: ProviderType.RawValue
}

enum LoginResultWithUserData {
    case success(User)
    case fail(LoginError)
}

class LoginUseCase: LoginUseCaseProtocol {
    // MARK: - properties
    private let appleRepository: AppleLoginRepositoryProtocol
    private let googleRepository: GoogleLoginRepositoryProtocol
    private let sceneRepositroy: SceneRepositoryProtocol
    private let firebaseRepository: FirebaseRepositoryProtocol
    private let firestoreUserRepository: FirestoreUserRepositoryProtocol

    // MARK: - lifecycle
    init(appleRepository: AppleLoginRepositoryProtocol,
         googleRepository: GoogleLoginRepositoryProtocol,
         sceneRepository: SceneRepositoryProtocol,
         firebaseRepository: FirebaseRepositoryProtocol,
         firestoreUserRepository: FirestoreUserRepositoryProtocol) {

        self.appleRepository = appleRepository
        self.googleRepository = googleRepository
        self.sceneRepositroy = sceneRepository
        self.firebaseRepository = firebaseRepository
        self.firestoreUserRepository = firestoreUserRepository
    }


    // MARK: - method
    func loginWithApple() -> Observable<LoginResultWithUserData> {
        return sceneRepositroy.getTopViewController()
            .withUnretained(self)
            .flatMapLatest { (self, vc) in
                self.appleRepository.authenticate(at: vc)
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

    func loginWithGoogle() {
        googleRepository.authenticate()
    }

    // MARK: - helper
    private func checkUserAlreadyRegistered(with user: User) -> Observable<String?> {
        let uid = user.uid
        return self.firestoreUserRepository.checkUser(with: uid)
    }

//    private func updateUserData(with docId: String, _ userData: User) -> User {
//        var updatedUser = userData
//        updatedUser.docId = docId
//        return updatedUser
//    }

}
