//
//  SearchTypeButtonView.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/7/23.
//

import UIKit
import SnapKit

class SearchTypeButtonView: UIView {
    //MARK: - properties
    let keywordButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("키워드", for: .normal)
        btn.setTitleColor(ThemeColor.primary, for: .normal)
        btn.titleLabel?.font = ThemeFont.demiBold(size: 15)
        return btn
    }()
    
    let addressButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("주소", for: .normal)
        btn.setTitleColor(ThemeColor.primary, for: .normal)
        btn.titleLabel?.font = ThemeFont.demiBold(size: 15)
        return btn
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [keywordButton, addressButton])
        sv.axis = .horizontal
        sv.spacing = 0
        sv.distribution = .fillEqually
        return sv
    }()
    
    //MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - method
    private func setupUI() {
        backgroundColor = .clear
        addCornerRadius(radius: 8)
        layer.borderWidth = 1
        layer.borderColor = ThemeColor.primary.cgColor
        
        addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
