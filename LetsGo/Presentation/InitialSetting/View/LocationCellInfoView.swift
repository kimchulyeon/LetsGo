//
//  LocationCellInfoView.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/8/23.
//

import UIKit
import SnapKit

class LocationCellInfoView: UIView {
    //MARK: - properties
    private let badgeView = LocationCellBadgeView()
    private let infoLabel: UILabel = {
        let lb = UILabel()
        return lb
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
        backgroundColor = .clear
        
        addSubview(badgeView)
        badgeView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(60)
        }
        
        addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.leading.equalTo(badgeView.snp.trailing).offset(5)
        }
    }
    
    func updateUI(with type: BadgeType, and location: Location) {
        badgeView.updateUI(type: type)
        
        switch type {
        case .address:
            infoLabel.text = location.address
            infoLabel.font = ThemeFont.demiBold(size: 14)
            infoLabel.textColor = ThemeColor.text
        case .postNumber:
            guard let postNumber = location.postNumber else { return }
            infoLabel.text = postNumber.isEmpty ? "-" : postNumber
            infoLabel.font = ThemeFont.regular(size: 13)
            infoLabel.textColor = ThemeColor.weakText
        case .phoneNumber:
            guard let phone = location.phone else { return }
            infoLabel.text = phone.isEmpty ? "-" : phone
            infoLabel.font = ThemeFont.regular(size: 13)
            infoLabel.textColor = ThemeColor.weakText
        }
    }
}
