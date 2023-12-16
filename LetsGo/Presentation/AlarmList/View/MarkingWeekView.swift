//
//  WeekButtonView.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/12/23.
//

import UIKit

class MarkingWeekView: UIView {
    //MARK: - properties
    let roundedButton: UIButton = {
        let v = UIButton()
        v.addCornerRadius(radius: 12)
        v.backgroundColor = ThemeColor.grayPrimary
        v.titleLabel?.font = ThemeFont.demiBold(size: 14)
        v.titleLabel?.textColor = ThemeColor.text
        return v
    }()
    
    //MARK: - lifecycle
    init(title: String) {
        super.init(frame: .zero)
        setupUI(with: title)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - method
    private func setupUI(with title: String) {
        backgroundColor = .clear
        
        addSubview(roundedButton)
        roundedButton.setTitle(title, for: .normal)
        roundedButton.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.edges.equalToSuperview()
        }
    }
}
