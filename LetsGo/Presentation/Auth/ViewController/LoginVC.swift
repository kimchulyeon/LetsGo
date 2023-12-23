//
//  LoginVC.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/15/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import AuthenticationServices
import JGProgressHUD

class LoginVC: UIViewController {
    //MARK: - properties
    private let bag = DisposeBag()
    private let viewModel: LoginVM
    
    private let logoImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "logo")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    private let descLabel: UILabel = {
        let lb = UILabel()
        lb.font = ThemeFont.demiBold(size: 16)
        lb.text = TextConstant.loginDesc
        lb.textColor = ThemeColor.weakText
        lb.numberOfLines = 0
        return lb
    }()
    private lazy var appleButton = ASAuthorizationAppleIDButton()
    private lazy var googleButton = GoogleButton()
    private lazy var vStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [ appleButton, googleButton ])
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.spacing = 12
        return sv
    }()
    lazy var loadingSpinner: JGProgressHUD = {
        let loader = JGProgressHUD(style: .dark)
        loader.textLabel.text = "Loading"
        return loader
    }()
    
    
    //MARK: - lifecycle
    init(viewModel: LoginVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        UserDefaultsManager.checkUserDefaultsValues()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        view.endEditing(true)
    }
    
    
    
    //MARK: - method
    private func setupUI() {
        view.backgroundColor = ThemeColor.background
        
        view.addSubview(logoImage)
        logoImage.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(-20)
            make.leading.equalTo(view.snp.leading).offset(-15)
            make.height.width.equalTo(300)
        }
        
        view.addSubview(descLabel)
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(-85)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
        
        googleButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        view.addSubview(vStackView)
        vStackView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.leading.equalTo(view.snp.leading).offset(30)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-55)
        }
    }
    
    private func bindViewModel() {
        let input = LoginVM.Input(appleLoginButtonTapped: appleButton.rx.tap.asObservable(),
                                  googleLoginButtonTapped: googleButton.rx.tap.asObservable())
        
        let output = viewModel.transform(input: input)
        
        output.loginResult
            .subscribe { isSucceed in
                if isSucceed {
                    // 성공하면 알람 설정하러 가기
                    print("성공 >>>> ")
                } else {
                    #warning("앱 실행 시 실패가 뜸")
                    print("실패 >>>> ")
                }
            }
            .disposed(by: bag)
//
//        
//        viewModel.isLoading
//            .observe(on: MainScheduler.instance)
//            .withUnretained(self)
//            .subscribe { (self, isLoading) in
//                if isLoading {
//                    self.loadingSpinner.show(in: self.view, animated: true)
//                } else {
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//                        self.loadingSpinner.dismiss(animated: true)
//                    }
//                }
//            }
//            .disposed(by: bag)
    }
    
    
    
    
//    private func handleAppleLogin() {
//        AppleService.shared.startSignInWithAppleFlow(view: self)
//    }
//    
//    private func handleGoogleLogin() {
//        GoogleService.shared.startSignInWithGoogleFlow(with: self)
//    }
    
    
//    private func bindAppleLoginButtonAction() {
//        viewModel.handleOAuthLogin(type: .apple)
//            .sink { [weak self] result in self?.handleLoginResult(result: result) }
//            .store(in: &cancellables)
//    }
//    
//    
//    private func bindGoogleLoginButtonAction() {
//        viewModel.handleOAuthLogin(type: .google)
//            .sink { [weak self] result in self?.handleLoginResult(result: result) }
//            .store(in: &cancellables)
//    }
//    
//    private func handleLoginResult(result: AuthResult) {
//        switch result {
//        case .success:
//            print("🟢 로그인 성공")
//            UserDefaultsManager.checkUserDefaultsValues()
//            viewModel.afterSuccessLogin()
//        case .failure(error: let error):
//            print("🔴 Error \(error)")
//            view.showAlert(content: "로그인에 실패하였습니다")
//        }
//    }
}
