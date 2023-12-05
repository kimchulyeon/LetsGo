//
//  SettingPageViewController.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/5/23.
//

import UIKit

class SettingPageViewController: UIPageViewController {
    //MARK: - properties
    let pages: [UIViewController] = [FirstSettingViewController()]
    let pageControl = UIPageControl()
    let initialPage = 0
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    //MARK: - method
    private func setupUI() {
        
    }
}
