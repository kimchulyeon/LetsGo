//
//  UserDefaultsDatasource.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/19/23.
//

import Foundation
import FirebaseAuth

class UserDefaultsDatasource: UserDefaultsDatasourceProtocol {
    func saveUser(_ user: User) {
        let encoder = JSONEncoder()
        if let encodedUser = try? encoder.encode(user) {
            UserDefaults.standard.set(encodedUser, forKey: UserDefaultsKey.user)
        }
    }
    
    func getSavedUser() -> User? {
        if let userData = UserDefaults.standard.data(forKey: UserDefaultsKey.user),
           let user = try? JSONDecoder().decode(User.self, from: userData) {
            
            return user
        }
        return nil
    }
    
    func removeSavedUser() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.user)
    }
}
