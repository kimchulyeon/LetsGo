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

//#if DEBUG
//import SwiftUI
//
//struct MainViewControllerPresentable: UIViewControllerRepresentable {
//    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//        
//    }
//    func makeUIViewController(context: Context) -> some UIViewController {
//        SettingPageViewController()
//    }
//}
//
//struct ViewControllerPrepresentable_PreviewProvider: PreviewProvider {
//    static var previews: some View {
//        MainViewControllerPresentable()
//            .ignoresSafeArea()
//    }
//}
//
//#endif
//
