//
//  GoogleButton.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/15/23.
//

import UIKit

class GoogleButton: UIButton {
    //MARK: - properties
    
    
    //MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - method
    private func configureButton() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 6
        self.backgroundColor = ThemeColor.strongBlue
        
        if let originalImage = UIImage(named: "google"), let resizedImage = originalImage.resized(to: CGSize(width: 16, height: 16)) {
            self.setImage(resizedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        self.setTitleColor(.white, for: .normal)
        self.setTitle("Sign in with Google", for: .normal)
        
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 1)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
    }
}
