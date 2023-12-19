//
//  AppleLoginRepositoryProtocol.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/17/23.
//

import UIKit
import RxSwift
import FirebaseAuth

protocol AppleLoginRepositoryProtocol {
    func authenticate(at vc: UIViewController?) -> Observable<OAuthCredential>
    
    func saveCredential(credential: AuthCredential)
}
