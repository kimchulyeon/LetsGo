//
//  DayOfWeekSettingVC.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/6/23.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class DayOfWeekSettingVC: UIViewController {
    //MARK: - properties
    private let viewModel: DayOfWeekSettingVM
    private let bag = DisposeBag()
    
    private let titleLabel: UILabel = {
        let lb = LabelFactory.basicLabel(font: .bold, size: 23, color: ThemeColor.text)
        lb.text = "요일 설정"
        return lb
    }()
    private let descLabel: UILabel = {
        let lb = LabelFactory.basicLabel(font: .regular, size: 14, color: ThemeColor.weakText)
        lb.text = "알람이 필요한 요일을 골라주세요"
        return lb
    }()
    private let button1 = SelectButton(text: "월요일", emoji: "😫")
    private let button2 = SelectButton(text: "화요일", emoji: "😣")
    private let button3 = SelectButton(text: "수요일", emoji: "😟")
    private let button4 = SelectButton(text: "목요일", emoji: "😳")
    private let button5 = SelectButton(text: "금요일", emoji: "😄")
    private let button6 = SelectButton(text: "토요일", emoji: "🤣")
    private let button7 = SelectButton(text: "일요일", emoji: "🥲")
    
    private lazy var buttonStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [button1, button2, button3, button4, button5, button6, button7])
        sv.axis = .vertical
        sv.spacing = 16
        sv.distribution = .fillEqually
        return sv
    }()
    private let nextButton = SelectButton(text: "다음", bgColor: ThemeColor.secondary)

    //MARK: - Lifecycle
    init(viewModel: DayOfWeekSettingVM) {
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

        view.addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.top.greaterThanOrEqualTo(descLabel.snp.bottom).offset(16)
            make.leading.equalTo(view.snp.leading).offset(24)
        }
        
        button1.snp.makeConstraints { make in
            make.height.equalTo(40)
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
        let buttonTapObservable = Observable.merge(buttons.enumerated().map { index, button  in
            return button.rx.tap.map { (DayOfWeek.allCases[index], index) }
        })
        
        let input = DayOfWeekSettingVM.Input(dayButtonTapped: buttonTapObservable,
                                             nextButtonTapped: nextButton.rx.tap.asObservable())
        
        let output = viewModel.transform(input: input)
        
        output.selectedDays
            .subscribe { [unowned self] selectedDaysListRelay in
                guard let days = selectedDaysListRelay.element else { return }
                buttons.forEach { $0.backgroundColor = ThemeColor.primary }
                
                if days.isEmpty {
                    nextButton.isEnabled = false
                    nextButton.backgroundColor = ThemeColor.weakSecondary
                }
                else {
                    nextButton.isEnabled = true
                    nextButton.backgroundColor = ThemeColor.secondary
                    
                    days.forEach { (day, index) in
                        buttons[index].backgroundColor = ThemeColor.strongPrimary
                    }
                }
            }
            .disposed(by: bag)
        
    }
}

