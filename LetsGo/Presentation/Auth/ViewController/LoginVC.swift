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
    
    private let welcomeLabel: UILabel = {
        let lb = UILabel()
        lb.text = "환영합니다"
        lb.font = ThemeFont.bold(size: 20)
        lb.tintColor = ThemeColor.text
        return lb
    }()
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "google")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    private lazy var appleButton = ASAuthorizationAppleIDButton(type: .default, style: .white)
    private lazy var googleButton = GoogleButton()
    private lazy var vStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            appleButton,
            googleButton
        ])
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
        view = GradientView(hex1: "000000", hex2: "#2B294E", cornerRadius: 0)
        
        view.addSubview(welcomeLabel)
        welcomeLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin)
            make.centerX.equalToSuperview()
            make.height.greaterThanOrEqualTo(40)
        }
        
        view.addSubview(logoImageView)
        logoImageView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        logoImageView.snp.makeConstraints { make in
            make.width.height.lessThanOrEqualTo(150)
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(welcomeLabel.snp.bottom).offset(16)
        }
        
        view.addSubview(vStackView)
        vStackView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(30)
            make.centerX.equalTo(view.snp.centerX)
            make.leading.equalTo(view.snp.leading).offset(30)
            make.bottom.lessThanOrEqualTo(view.snp.bottomMargin).offset(-24)
        }
    }
    
    private func bindViewModel() {
        let input = LoginVM.Input(appleLoginButtonTapped: appleButton.rx.tap.asObservable(),
                                  googleLoginButtonTapped: googleButton.rx.tap.asObservable())
        
        let output = viewModel.transform(input: input)
        
        viewModel.isLoading
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .subscribe { (self, isLoading) in
                if isLoading {
                    self.loadingSpinner.show(in: self.view, animated: true)
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        self.loadingSpinner.dismiss(animated: true)
                    }
                }
            }
            .disposed(by: bag)
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
