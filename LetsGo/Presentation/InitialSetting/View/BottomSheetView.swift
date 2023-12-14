//
//  BottomSheetView.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/8/23.
//

import UIKit
import SnapKit

class BottomSheetView: UIView {
    //MARK: - properties
    private let noticeLabel: UILabel = {
        let lb = LabelFactory.basicLabel(font: .bold, size: 20, color: ThemeColor.text)
        lb.text = "선택한 주소가 맞나요?"
        return lb
    }()
    private let placeNameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "장소이름"
        lb.font = ThemeFont.demiBold(size: 18)
        lb.textColor = ThemeColor.text
        return lb
    }()
    private let topInfoView = LocationCellInfoView()
    private let bottomInfoView = LocationCellInfoView()
    private lazy var infoViewStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [topInfoView, bottomInfoView])
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.spacing = 3
        return sv
    }()
    let cancelButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("아니요", for: .normal)
        btn.setTitleColor(ThemeColor.weakText, for: .normal)
        btn.backgroundColor = .clear
        btn.addCornerRadius(radius: 8)
        btn.layer.borderColor = ThemeColor.primary.cgColor
        btn.layer.borderWidth = 1
        return btn
    }()
    let confirmButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("맞아요", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = ThemeColor.primary
        btn.addCornerRadius(radius: 8)
        return btn
    }()
    private lazy var buttonStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [cancelButton, confirmButton])
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.spacing = 16
        return sv
    }()
    
    //MARK: - lifecycle
    init() {
        super.init(frame: .zero)
        
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - method
    private func setupUI() {
        backgroundColor = ThemeColor.background
        layer.cornerRadius = 15
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        addSubview(noticeLabel)
        noticeLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        addSubview(placeNameLabel)
        placeNameLabel.snp.makeConstraints { make in
            make.top.equalTo(noticeLabel.snp.bottom).offset(16)
            make.leading.equalTo(noticeLabel.snp.leading)
            make.trailing.equalTo(noticeLabel.snp.trailing)
        }
        
        addSubview(infoViewStackView)
        infoViewStackView.snp.makeConstraints { make in
            make.top.equalTo(placeNameLabel.snp.bottom).offset(12)
            make.leading.equalTo(noticeLabel.snp.leading)
            make.trailing.equalTo(noticeLabel.snp.trailing)
        }
        
        addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints { make in
            make.leading.equalTo(noticeLabel.snp.leading)
            make.trailing.equalTo(noticeLabel.snp.trailing)
            make.bottom.equalTo(snp.bottom).offset(-24)
        }
    }
    
    func updateUI(with location: Location, and buttonType: SearchType) {
        placeNameLabel.text = location.placeName
        topInfoView.updateUI(with: BadgeType.address, and: location)
        
        switch buttonType {
        case .keyword:
            bottomInfoView.updateUI(with: BadgeType.phoneNumber, and: location)
        case .address:
            bottomInfoView.updateUI(with: BadgeType.postNumber, and: location)
        }
    }
}

