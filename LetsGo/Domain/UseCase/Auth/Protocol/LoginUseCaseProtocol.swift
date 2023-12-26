//
//  LoginUseCaseProtocol.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/17/23.
//

import Foundation
import RxSwift

protocol LoginUseCaseProtocol {
    func oauthLogin(type: ProviderType) -> Observable<LoginResultWithUserData>
    func saveUserForLogin(_ user: User)
}
