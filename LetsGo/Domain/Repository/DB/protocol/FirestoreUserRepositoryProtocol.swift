//
//  FirestoreUserRepositoryProtocol.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/24/23.
//

import Foundation
import RxSwift

protocol FirestoreUserRepositoryProtocol {
    func checkUser(with uid: String?) -> Observable<String?>
    func getUser(with docId: String) -> Observable<LoginResultWithUserData>
    func saveUser(_ data: User) -> Observable<LoginResultWithUserData>
}
