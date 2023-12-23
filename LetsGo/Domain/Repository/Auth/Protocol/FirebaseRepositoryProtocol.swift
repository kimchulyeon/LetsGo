//
//  FirebaseRepositoryProtocol.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/23/23.
//

import Foundation
import FirebaseAuth
import RxSwift

protocol FirebaseRepositoryProtocol {
    func login(with user: User) -> Observable<User>
}
