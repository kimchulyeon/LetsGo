//
//  LoginVM.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/15/23.
//

import UIKit
import RxSwift
import RxCocoa
import FirebaseAuth

class LoginVM {
    //MARK: - properties
    private let bag = DisposeBag()
    private let loginUseCase: LoginUseCaseProtocol
    
    struct Input {
        let appleLoginButtonTapped: Observable<Void>
        let googleLoginButtonTapped: Observable<Void>
    }
    
    struct Output {
        let loginResult = BehaviorSubject(value: false)
    }

    //MARK: - lifecycle
    init(loginUseCase: LoginUseCaseProtocol) {
        self.loginUseCase = loginUseCase
    }
    

    //MARK: - method
    func transform(input: Input) -> Output {
        let output = Output()
        
        input.appleLoginButtonTapped
            .withUnretained(self)
            .flatMapLatest { (self, _) in
                self.loginUseCase.loginWithApple()
            }
            .subscribe { _ in
                print("APPLE LOGIN >>>>")
            }
            .disposed(by: bag)
            
        
        input.googleLoginButtonTapped
            .subscribe { _ in
                // Usecase
            }
            .disposed(by: bag)
            
        
        return output
    }
    
//    func handleOAuthLogin(type: ProviderType) -> AnyPublisher<AuthResult, Never> {
//        return oAuthCredentialPublisher(according: type)
//            .flatMap { [weak self] oAuthCredential in
//                self?.isLoading = true
//                return AuthService.shared.oAuth(provider: .apple, credential: oAuthCredential)
//            }
//            .flatMap { [weak self] authResult in
//                StorageService.getUserData(with: authResult)
//                    .catch { _ in // 신규 유저
//                        let userData = UserData(userId: authResult?.user.uid,
//                                                name: authResult?.user.displayName,
//                                                email: authResult?.user.email,
//                                                provider: type.rawValue)
//                        
//                        return StorageService.saveUserData(userData)
//                    }
//                    .handleEvents(receiveCompletion: { [weak self] _ in
//                        self?.isLoading = false
//                    })
//            }
//            .flatMap { userData in
//                UserDefaultsManager.saveUserInfo(userData: userData)
//            }
//            .flatMap { userData in
//                StorageService.uploadImage(with: userData.userId, UIImage(named: "chat_logo")!)
//            }
//            .flatMap { url in
//                UserDefaultsManager.saveUserImage(url: url)
//            }
//            .map { _ in
//                AuthResult.success
//            }
//            .replaceError(with: AuthResult.failure(error: AuthError.loginError))
//            .handleEvents(receiveCompletion: { [weak self] _ in
//                self?.isLoading = false
//            })
//            .eraseToAnyPublisher()
//    }
    
//    func afterSuccessLogin() {
//        let chatViewModel = ChatListViewModel()
//        let c_navigationController = UINavigationController(rootViewController: ChatListViewController(viewModel: chatViewModel))
//        
//        CommonUtil.changeRootView(to: c_navigationController)
//    }
}


//MARK: - helper
//extension LoginViewModel {
//    /// 로그인 제공자 타입에 따라 반환받은 Credential를 가진 퍼블리셔를 리턴
//    private func oAuthCredentialPublisher(according type: ProviderType) -> AnyPublisher<AuthCredential, Error> {
//        var servicePublisher: AnyPublisher<AuthCredential, Error>
//        
//        switch type {
//            case .apple: servicePublisher = AppleService.shared.appleOAuthCredentialPublisher
//            case .google: servicePublisher = GoogleService.shared.googleOAuthCredentialPublisher
//            case .email: servicePublisher = Empty<AuthCredential, Error>().eraseToAnyPublisher()
//        }
//        
//        return servicePublisher
//    }
//}
//
