//
//  UserRepository.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/27/23.
//

import Foundation

class UserRepository: UserRepositoryProtocol {
    // MARK: - properties
    private let userDefaultsDatasource: UserDefaultsDatasourceProtocol
    
    // MARK: - lifecycle
    init(userDefaultsDatasource: UserDefaultsDatasourceProtocol) {
        self.userDefaultsDatasource = userDefaultsDatasource
    }
    
    // MARK: - method
    func saveUser(_ user: User) {
        userDefaultsDatasource.saveUser(user)
    }
}
