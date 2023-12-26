//
//  GoogleService.swift
//  ChatApp
//
//  Created by chulyeon kim on 11/17/23.
//

import GoogleSignIn
import FirebaseAuth
import FirebaseCore
import RxSwift

final class GoogleService {
    static let shared = GoogleService()
    private init() { }

    private let googleUserSubject = PublishSubject<User?>()
    var googleUserDataObservable: Observable<User?> {
        googleUserSubject.asObserver()
    }
}



extension GoogleService {
    func startSignInWithGoogleFlow(with view: UIViewController) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        GIDSignIn.sharedInstance.signIn(withPresenting: view) { [weak self] result, error in
            if let weakSelf = self,
               let error = error {
                print(error.localizedDescription)
                weakSelf.googleUserSubject.onNext(nil)
                return
            }
            guard let weakSelf = self,
                  let user = result?.user,
                  let idToken = user.idToken?.tokenString else {

                print("Error There is no user or idToken while google sign in :::::::: ❌")
                return
            }

            let username = result?.user.profile?.name
            let email = result?.user.profile?.email
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)

            let userEntity = User(uid: nil,
                            docId: nil,
                            username: username ?? "",
                            email: email,
                            credential: credential,
                            provider: ProviderType.Google.rawValue)
            
            weakSelf.googleUserSubject.onNext(userEntity)
        }
    }
}
