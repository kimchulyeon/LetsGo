//
//  UserDefaultsDatasourceProtocol.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/19/23.
//

import Foundation
import FirebaseAuth

protocol UserDefaultsDatasourceProtocol {
    func saveUser(_ user: User)
    func getSavedUser() -> User?
}
