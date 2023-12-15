//
//  AuthService.swift
//  ChatApp
//
//  Created by chulyeon kim on 11/15/23.
//

import UIKit
import RxSwift
import FirebaseCore
import FirebaseAuth

class AuthService {
    static let shared = AuthService()
    private init() { }
    
    private let bag = DisposeBag()
    
    /// OAuth
//    func oAuth(provider: ProviderType, credential: AuthCredential) -> AnyPublisher<AuthDataResult?, Error> {
//        return Future<AuthDataResult?, Error> { promise in
//            Auth.auth().signIn(with: credential) { authResult, error in
//                if let error = error {
//                    print("🔴 OAuth Login Error >>>> \(error.localizedDescription)")
//                    return promise(.failure(error))
//                }
//                
//                return promise(.success(authResult))
//            }
//        }
//        .eraseToAnyPublisher()
//    }
}
