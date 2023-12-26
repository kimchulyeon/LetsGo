//
//  GoogleLoginRepository.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/17/23.
//

import UIKit
import RxSwift

class GoogleLoginRepository: GoogleLoginRepositoryProtocol {
    func authenticate(at vc: UIViewController?) -> Observable<User?> {
        guard let vc = vc else { return Observable.empty() }
        GoogleService.shared.startSignInWithGoogleFlow(with: vc)
        return GoogleService.shared.googleUserDataObservable
    }
}
