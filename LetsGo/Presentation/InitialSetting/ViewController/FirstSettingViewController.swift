//
//  InitialSettingViewController.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/5/23.
//

import UIKit
import SnapKit

class FirstSettingViewController: UIViewController {
    //MARK: - properties
    private let titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "그룹 설정"
        return lb
    }()
    
    private let button1: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "house"), for: .normal)
        btn.setTitle("기타", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .yellow
        return btn
    }()
    
    private let button2: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "house"), for: .normal)
        btn.setTitle("직장인", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .yellow
        return btn
    }()
    
    private let button3: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "house"), for: .normal)
        btn.setTitle("학생", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .yellow
        return btn
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [button1, button2, button3])
        sv.axis = .vertical
        sv.spacing = 16
        return sv
    }()
    
    private let nextButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("다음", for: .normal)
        btn.backgroundColor = .systemPink
        return btn
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    //MARK: - method
    private func setupUI() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
        }
        
        view.addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(32)
            make.leading.equalTo(view.snp.leading).offset(24)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-24)
            make.leading.equalTo(view.snp.leading).offset(24)
        }
    }
}

#if DEBUG
import SwiftUI
struct Preview: UIViewControllerRepresentable {
    
    // 여기 ViewController를 변경해주세요
    func makeUIViewController(context: Context) -> UIViewController {
        FirstSettingViewController()
    }
    
    func updateUIViewController(_ uiView: UIViewController,context: Context) {
        // leave this empty
    }
}

struct ViewController_PreviewProvider: PreviewProvider {
    static var previews: some View {
        Group {
            Preview()
                .edgesIgnoringSafeArea(.all)
                .previewDisplayName("Preview")
                .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro"))
        }
    }
}
#endif
