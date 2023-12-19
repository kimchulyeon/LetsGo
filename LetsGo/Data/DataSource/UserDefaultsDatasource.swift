//
//  UserDefaultsDatasource.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/19/23.
//

import Foundation
import FirebaseAuth

class UserDefaultsDatasource: UserDefaultsDatasourceProtocol {
    func saveCredential(credential: AuthCredential) {
        UserDefaults.standard.set(credential, forKey: UserDefaultsKey.credential)
    }
}
