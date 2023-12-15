//
//  GradientView.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/15/23.
//

import UIKit

class GradientView: UIView {
    //MARK: - properties
    private let gradientLayer = CAGradientLayer()

    
    //MARK: - lifecycle
    init(hex1: String, hex2: String, cornerRadius: CGFloat) {
        super.init(frame: .zero)
        
        setupGradientLayer(hex1: hex1, hex2: hex2, cornerRadius: cornerRadius)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - method
    private func setupGradientLayer(hex1: String, hex2: String, cornerRadius: CGFloat) {
        gradientLayer.colors = [
            UIColor(hexCode: hex1, alpha: 1).cgColor,
            UIColor(hexCode: hex2, alpha: 1).cgColor
        ]
        gradientLayer.cornerRadius = cornerRadius
        layer.insertSublayer(gradientLayer, at: 0)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = bounds
    }
}
