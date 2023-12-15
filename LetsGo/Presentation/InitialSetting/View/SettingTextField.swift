//
//  SearchTextField.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/7/23.
//

import UIKit
import RxSwift

class SettingTextField: UIView {
    
    //MARK: - properties
    private let leftImageView: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = ThemeColor.moreWeakText
        return iv
    }()
    let textField: UITextField = {
        let tf = UITextField()
        tf.autocapitalizationType = .none
        tf.textColor = ThemeColor.yellow
        return tf
    }()
    
    //MARK: - lifecycle
    init(leftImage: UIImage = UIImage(systemName: "magnifyingglass")!, placeholder: String = "주소를 입력해주세요", fontSize: CGFloat = 14) {
        super.init(frame: .zero)
        setupUI()
        leftImageView.image = leftImage
        textField.placeholder = placeholder
        textField.font = ThemeFont.regular(size: fontSize)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - method
    private func setupUI() {
        backgroundColor = ThemeColor.graySecondary
        addCornerRadius(radius: 8)

        addSubview(leftImageView)
        leftImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
            make.width.height.equalTo(25)
        }
        
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.bottom.equalToSuperview().offset(-6)
            make.leading.equalTo(leftImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(8)
        }
        
    }
}
