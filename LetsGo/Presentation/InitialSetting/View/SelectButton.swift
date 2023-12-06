//
//  SelectButton.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/6/23.
//

import UIKit
import SnapKit

class SelectButton: UIButton {
    //MARK: - properties
    private let leftEmoji: UILabel = {
        let ib = UILabel()
        return ib
    }()
    
    private let buttonText: UILabel = {
        let lb = LabelFactory.basicLabel(font: .demiBold, size: 18, color: UIColor.white)
        return lb
    }()

    //MARK: - lifecycle
    init(text: String, emoji: String? = nil, bgColor: UIColor = ThemeColor.primary) {
        super.init(frame: .zero)
        setupUI(hasEmoji: emoji != nil, bgColor: bgColor)
        setupButton(with: text, emoji: emoji)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - method
    private func setupButton(with text: String, emoji: String?) {
        if let emoji = emoji {
            leftEmoji.text = emoji
        }
        buttonText.text = text
    }
    
    private func setupUI(hasEmoji: Bool, bgColor: UIColor) {
        backgroundColor = bgColor
        addCornerRadius(radius: 8)
        
        if hasEmoji {
            addSubview(leftEmoji)
            leftEmoji.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.equalTo(snp.leading).offset(16)
            }
        }
        
        addSubview(buttonText)
        buttonText.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
}
