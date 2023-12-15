//
//  ArrivalTimeSettingVC.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/11/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ArrivalTimeSettingVC: UIViewController {
    //MARK: - properties
    private let bag = DisposeBag()
    private let viewModel: ArrivalTimeSettingVM
    
    private let titleLabel: UILabel = {
        let lb = LabelFactory.basicLabel(font: .bold, size: 23, color: ThemeColor.text)
        lb.text = "도착시간 설정"
        return lb
    }()
    private let descLabel: UILabel = {
        let lb = LabelFactory.basicLabel(font: .regular, size: 14, color: ThemeColor.weakText)
        lb.text = "몇시까지 도착해야하는지 시간을 설정해주세요"
        return lb
    }()
    private let arrivalTimePicker: UIDatePicker = {
        let pv = UIDatePicker()
        pv.datePickerMode = .time
        pv.preferredDatePickerStyle = .wheels
        pv.minuteInterval = 10
        pv.locale = Locale(identifier: "ko_KR")
        return pv
    }()
    private let nextButton = SelectButton(text: "다음", bgColor: ThemeColor.yellow)
    
    //MARK: - Lifecycle
    init(viewModel: ArrivalTimeSettingVM) {
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
        
        view.addSubview(arrivalTimePicker)
        arrivalTimePicker.snp.makeConstraints { make in
            make.top.equalTo(descLabel.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
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
        let input = ArrivalTimeSettingVM.Input(timeSelected: arrivalTimePicker.rx.value.asObservable(),
                                               nextButtonTapped: nextButton.rx.tap.asObservable())
        
        let output = viewModel.transform(input: input)
        
        output.moveToNext
            .subscribe { _ in
                print("다음으로 이동 >>>> ")
            }
            .disposed(by: bag)
    }
}
