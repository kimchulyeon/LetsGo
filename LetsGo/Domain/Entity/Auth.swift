//
//  Auth.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/27/23.
//

import Foundation
import FirebaseAuth

enum ProviderType: String, Codable {
    case Apple = "apple"
    case Google = "google"
}

enum LoginError: Error {
    case oauthLoginFailed(String)
    case firebaseLoginFailed(String)
    case userFetchFailed(String)
    case userSaveFailed(String)
}

struct User: Codable {
    var uid: String?
    var docId: String?
    let username: String
    let email: String?
    var credential: AuthCredential?
    let provider: ProviderType.RawValue
    
    private enum CodingKeys: String, CodingKey {
       case uid, docId, username, email, provider
   }
}

enum LoginResultWithUserData {
    case success(User)
    case fail(LoginError)
}
