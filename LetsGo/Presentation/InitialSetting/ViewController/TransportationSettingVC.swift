//
//  TransportationSettingVC.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/5/23.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class TransportationSettingVC: UIViewController {
    //MARK: - properties
    private let viewModel = TransportationSettingVM()
    private let bag = DisposeBag()
    
    private let titleLabel: UILabel = {
        let lb = LabelFactory.basicLabel(font: .bold, size: 23, color: ThemeColor.text)
        lb.text = "가는 방법 설정"
        return lb
    }()
    private let descLabel: UILabel = {
        let lb = LabelFactory.basicLabel(font: .regular, size: 14, color: ThemeColor.weakText)
        lb.text = "시간 측정을 위해 가는 방법을 설정해주세요"
        return lb
    }()
    private let button1 = SelectButton(text: "도보", emoji: "🦶")
    private let button2 = SelectButton(text: "대중교통", emoji: "🚇")
    private let button3 = SelectButton(text: "자동차", emoji: "🚘")
    private let button4 = SelectButton(text: "자전거", emoji: "🚴")
    private lazy var buttonStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [button1, button2, button3, button4])
        sv.axis = .vertical
        sv.spacing = 16
        sv.distribution = .fillEqually
        return sv
    }()
    private let nextButton = SelectButton(text: "다음", bgColor: ThemeColor.secondary)

    //MARK: - Lifecycle
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

        view.addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.top.greaterThanOrEqualTo(descLabel.snp.bottom).offset(16)
            make.leading.equalTo(view.snp.leading).offset(24)
        }
        
        button1.snp.makeConstraints { make in
            make.height.equalTo(55)
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
        guard let buttons = buttonStackView.arrangedSubviews as? [UIButton] else { return }
        let buttonTappedObservable = Observable.merge(buttons.enumerated().map { index, button in
            return button.rx.tap.map { (Transportation.allCases[index], index) }
        })
        
        let input = TransportationSettingVM.Input(transportationButtonTapped: buttonTappedObservable,
                                                  nextButtonTapped: nextButton.rx.tap.asObservable())
        
        let output = viewModel.transform(input: input)
        
        output.selectedTransportation
            .subscribe(onNext: { [unowned self] (transportation, index) in
                print("\n📂파일 : \(#file)\n📏줄 : \(#line)\n🚀함수 : \(#function)\n✅ 선택된 교통수단 : \(transportation) \n")
                if transportation == .none {
                    nextButton.isEnabled = false
                    nextButton.backgroundColor = ThemeColor.weakSecondary
                }
                else {
                    nextButton.isEnabled = true
                    nextButton.backgroundColor = ThemeColor.secondary
                    buttons.forEach{ $0.backgroundColor = ThemeColor.primary }
                    buttons[index].backgroundColor = ThemeColor.strongPrimary
                }
                
            })
            .disposed(by: bag)
        
        output.moveToNext
            .subscribe { _ in
                print("✅ 다음 단계로 이동 >>>> ")
            }
            .disposed(by: bag)
    }
}
