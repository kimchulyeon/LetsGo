//
//  BaseTabBarController.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/12/23.
//

import UIKit

class BaseTabBarController: UITabBarController {
    //MARK: - properties
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupUI()
        setupTabBarItems()
    }
    
    //MARK: - method
    private func setupUI() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = ThemeColor.background
        tabBar.tintColor = .black
        tabBar.scrollEdgeAppearance = appearance
        tabBar.standardAppearance = appearance
    }
    
    private func setupTabBarItems() {
        let alarmListVM = AlarmListVM()
        let alarmListVC = AlarmListVC(viewModel: alarmListVM)
        setTabBarItem(of: alarmListVC, image: UIImage(systemName: "alarm"), selectedImage: UIImage(systemName: "alarm.fill"))
        let alarmNav = UINavigationController(rootViewController: alarmListVC)
        
        let appSettingVM = AppSettingVM()
        let appSettingVC = AppSettingVC(viewModel: appSettingVM)
        setTabBarItem(of: appSettingVC, image: UIImage(systemName: "gearshape"), selectedImage: UIImage(systemName: "gearshape.fill"))
        let appNav = UINavigationController(rootViewController: appSettingVC)
        
        viewControllers = [alarmNav, appNav]
    }
    
    private func setTabBarItem(of vc: UIViewController, image: UIImage?, selectedImage: UIImage?) {
        vc.tabBarItem.image = image
        vc.tabBarItem.selectedImage = selectedImage
    }
}
