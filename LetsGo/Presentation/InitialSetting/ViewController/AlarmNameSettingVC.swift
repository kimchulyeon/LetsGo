//
//  AlarmNameSettingVC.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/14/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class AlarmNameSettingVC: UIViewController {
    //MARK: - properties
    private let viewModel: AlarmNameSettingVM
    private let bag = DisposeBag()

    private let titleLabel: UILabel = {
        let lb = LabelFactory.basicLabel(font: .bold, size: 23, color: ThemeColor.text)
        lb.text = "알람 이름 설정"
        return lb
    }()
    private let descLabel: UILabel = {
        let lb = LabelFactory.basicLabel(font: .regular, size: 14, color: ThemeColor.weakText)
        lb.text = "무엇을 위한 알람인가요?"
        return lb
    }()
    private let textFieldView = InitialSettingTextField(leftImage: UIImage(),
                                             placeholder: "학교 가기... 회사가기...",
                                             fontSize: 28)
    private let nextButton = SelectButton(text: "다음")
    
    //MARK: - Lifecycle
    init(viewModel: AlarmNameSettingVM) {
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
    
    //MARK: - method
    private func setupUI() {
        view.backgroundColor = ThemeColor.background

        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32)
        }

        view.addSubview(descLabel)
        descLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
        }
        
        view.addSubview(textFieldView)
        textFieldView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(32)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-24)
            make.leading.equalTo(view.snp.leading).offset(24)
        }

    }
    
    private func bindViewModel() {
        let input = AlarmNameSettingVM.Input(nameBeInput: textFieldView.textField.rx.text.asObservable(),
                                             nextButtonTapped: nextButton.rx.tap.asObservable())
        
        let output = viewModel.transform(input: input)
        
        output.alarmName
            .withUnretained(self)
            .subscribe { (self, alarmName) in
                if alarmName.isEmpty {
                    self.nextButton.isEnabled = false
                    self.nextButton.backgroundColor = ThemeColor.grayPrimary
                } else {
                    self.nextButton.isEnabled = true
                    self.nextButton.backgroundColor = ThemeColor.blackPrimary
                }
            }
            .disposed(by: bag)
    }
}

