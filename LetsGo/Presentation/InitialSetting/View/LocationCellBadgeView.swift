//
//  LocationCellBadgeView.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/8/23.
//

import UIKit
import SnapKit

enum BadgeType: String {
    case address = "주소"
    case postNumber = "우편번호"
    case phoneNumber = "전화번호"
}

class LocationCellBadgeView: UIView {
    //MARK: - properties
    private let badgeLabel: UILabel = {
        let lb = UILabel()
        lb.font = ThemeFont.demiBold(size: 10)
        lb.textColor = .white
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
        addCornerRadius(radius: 8)
        
        addSubview(badgeLabel)
        badgeLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func updateUI(type: BadgeType) {
        badgeLabel.text = type.rawValue

        switch type {
        case .address: 
            backgroundColor = ThemeColor.weakPrimary
        case .postNumber, .phoneNumber:
            backgroundColor = ThemeColor.darkGray
        }
    }
}
