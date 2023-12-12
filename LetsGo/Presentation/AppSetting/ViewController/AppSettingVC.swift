//
//  AppSettingVC.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/12/23.
//

import UIKit

class AppSettingVC: UIViewController {
    //MARK: - properties
    private let viewModel: AppSettingVM
    
    //MARK: - Lifecycle
    init(viewModel: AppSettingVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    //MARK: - method
    private func setupUI() {
        view.backgroundColor = .systemGreen
    }
}
