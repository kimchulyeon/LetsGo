//
//  FirebaseRepository.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/23/23.
//

import Foundation
import FirebaseAuth
import RxSwift

class FirebaseRepository: FirebaseRepositoryProtocol {
    func login(with user: User) -> Observable<User> {
        FirebaseService.shared.login(with: user)
    }
}
