//
//  FirestoreUserRepository.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/24/23.
//

import Foundation
import RxSwift
import FirebaseFirestore
import FirebaseAuth

let DB = Firestore.firestore()

enum DBError: Error {
    case noUid
    case cannotGetUser
}

class FirestoreUserRepository: FirestoreUserRepositoryProtocol {
    // MARK: - properties
    let USER_COL = DB.collection("users")

    // MARK: - method
    func checkUser(with uid: String?) -> Observable<String?> {
        return Observable<String?>.create { [unowned self] observer in
            guard let uid = uid else {
                observer.onError(DBError.noUid)
                return Disposables.create()
            }
            
            USER_COL.whereField(FirestoreField.uid, isEqualTo: uid).getDocuments { snapshot, error in
                if let error = error {
                    print("❌ Error while searching user in firestore with \(error.localizedDescription)")
                    observer.onNext(nil)
                    return
                }
                
                if let snapshot = snapshot,
                   let document = snapshot.documents.first {

                    print("🚀 가입된 유저입니다 >>>> ")
                    let docId = document.documentID
                    observer.onNext(docId)
                    observer.onCompleted()
                } else {
                    print("🚀 신규 유저입니다 >>>> ")
                    observer.onNext(nil)
                    observer.onCompleted()
                }
            }
            
            return Disposables.create()
        }
        
    }
    
    func getUser(with docId: String) -> Observable<LoginResultWithUserData> {
        return Observable<LoginResultWithUserData>.create { [unowned self] observer in
            USER_COL.document(docId).getDocument { snapshot, error in
                if let error = error {
                    observer.onNext(LoginResultWithUserData.fail(LoginError.userFetchFailed(error.localizedDescription)))
                    return
                }
                
                if let snapshot = snapshot,
                   let name = snapshot.get(FirestoreField.name) as? String,
                   let email = snapshot.get(FirestoreField.email) as? String,
                   let uid = snapshot.get(FirestoreField.uid) as? String,
                   let docId = snapshot.get(FirestoreField.docId) as? String,
                   let provider = snapshot.get(FirestoreField.provider) as? String {
                        
                    let user = User(uid: uid,
                                    docId: docId,
                                    username: name,
                                    email: email,
                                    credential: nil,
                                    provider: provider)
                    
                    print("가입된 유저 : \(user)")
                    
                    observer.onNext(LoginResultWithUserData.success(user))
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
    
    func saveUser(_ user: User) -> Observable<LoginResultWithUserData> {
        let DOC = USER_COL.document()
        let DOC_ID = DOC.documentID
        
        guard let uid = user.uid else {
            return Observable.just(LoginResultWithUserData.fail(LoginError.userSaveFailed("")))
        }
        
        print("🥺 저장 데이터 : \(user)")
        
        let data: [String: Any] = [
            FirestoreField.name: user.username,
            FirestoreField.email: user.email ?? "",
            FirestoreField.uid: uid,
            FirestoreField.docId: DOC_ID,
            FirestoreField.createdAt: FieldValue.serverTimestamp(),
            FirestoreField.provider: user.provider
        ]
        
        return Observable<LoginResultWithUserData>.create { observer in
            DOC.setData(data) { error in
                if let error = error {
                    observer.onNext(LoginResultWithUserData.fail(LoginError.userSaveFailed(error.localizedDescription)))
                    return
                }
                
                observer.onNext(LoginResultWithUserData.success(user))
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}
