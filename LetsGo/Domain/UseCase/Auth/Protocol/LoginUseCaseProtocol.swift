//
//  LoginUseCaseProtocol.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/17/23.
//

import Foundation
import RxSwift

protocol LoginUseCaseProtocol {
    func loginWithApple() -> Observable<Void>
    func loginWithGoogle() -> Void
}
