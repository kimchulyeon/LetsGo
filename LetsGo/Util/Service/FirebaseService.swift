//
//  FirebaseService.swift
//  ChatApp
//
//  Created by chulyeon kim on 11/15/23.
//

import UIKit
import RxSwift
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

class FirebaseService {
    // MARK: - properties
    static let shared = FirebaseService()
    private init() { }

    private let bag = DisposeBag()


    // MARK: - method
    func login(with userData: User) -> Observable<User> {
        return Observable<User>.create { observer in
            guard let credential = userData.credential else {
                observer.onError(LoginError.firebaseLoginFailed(""))
                return Disposables.create()
            }
            
            Auth.auth().signIn(with: credential) { [weak self] result, error in
                guard let weakSelf = self else { return }
                if let error = error {
                    print("Error \(error.localizedDescription) :::::::: ❌")
                    observer.onError(LoginError.firebaseLoginFailed(error.localizedDescription))
                    return
                }
                guard let uid = result?.user.uid else {
                    print("Error There is no UID while signing in Apple :::::::: ❌")
                    observer.onError(LoginError.firebaseLoginFailed("No UID"))
                    return
                }

                let updatedUserData = weakSelf.updateUserData(with: uid, userData)
                observer.onNext(updatedUserData)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    
    // MARK: - helper
    private func updateUserData(with uid: String, _ userData: User) -> User {
        var updatedUserData = userData
        updatedUserData.uid = uid
        return updatedUserData
    }

}
