//
//  ComposeAlarmVC.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/14/23.
//

import UIKit

class ComposeAlarmVC: UIViewController {
    //MARK: - properties
    private let viewModel: ComposeAlarmVM
    
    //MARK: - Lifecycle
    init(viewModel: ComposeAlarmVM) {
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
        view.backgroundColor = .brown
    }
}
