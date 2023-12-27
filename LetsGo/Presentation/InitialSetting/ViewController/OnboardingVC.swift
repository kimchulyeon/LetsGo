//
//  OnboardingVC.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/27/23.
//

import UIKit
import SnapKit

class OnboardingVC: UIViewController {
    //MARK: - properties
    private let titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = TextConstant.onboardingTitle
        lb.font = ThemeFont.bold(size: 34)
        lb.textColor = ThemeColor.text
        return lb
    }()
    private let subTitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = TextConstant.onboardingSubTitle
        lb.font = ThemeFont.demiBold(size: 18)
        lb.textColor = ThemeColor.weakText
        return lb
    }()
    private let characterImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "logo-img")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    private lazy var startButton: SelectButton = {
        let btn = SelectButton(text: "시작하기", bgColor: ThemeColor.blackPrimary)
        let action = UIAction { [unowned self] _ in
            handleStartButton()
        }
        btn.addAction(action, for: .touchUpInside)
        return btn
    }()
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    //MARK: - method
    private func setupUI() {
        view.backgroundColor = ThemeColor.background
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(characterImage)
        characterImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(subTitleLabel.snp.bottom).offset(8)
            make.height.equalTo(400)
        }
        
        view.addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-24)
            make.centerX.equalToSuperview()
            make.leading.equalTo(view.snp.leading).offset(24)
            make.height.equalTo(55)
        }
    }
    
    private func handleStartButton() {
        let vm = InitialSettingsPageVM()
        let vc = InitialSettingsPageVC(viewModel: vm)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
