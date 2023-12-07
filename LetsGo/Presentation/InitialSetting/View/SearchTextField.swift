//
//  SearchTextField.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/7/23.
//

import UIKit
import RxSwift

class SearchTextField: UIView {
    
    //MARK: - properties
    private let leftImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "magnifyingglass")
        iv.tintColor = ThemeColor.secondary
        return iv
    }()
    let textField: UITextField = {
        let tf = UITextField()
        tf.autocapitalizationType = .none
        tf.placeholder = "주소를 입력해주세요"
        tf.font = ThemeFont.regular(size: 14)
        return tf
    }()
    
    //MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - method
    private func setupUI() {
        backgroundColor = ThemeColor.lightGray
        addCornerRadius(radius: 8)

        addSubview(leftImageView)
        leftImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.bottom.equalToSuperview().offset(-6)
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
