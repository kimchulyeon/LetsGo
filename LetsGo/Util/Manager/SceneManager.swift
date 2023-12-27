//
//  SceneManager.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/27/23.
//

import UIKit

class SceneManager {
    static let shared = SceneManager()

    private init() {}

    func changeRootViewController(to viewController: UIViewController, animated: Bool = true) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate,
              let window = sceneDelegate.window else { return }

        if animated {
            UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: {
                window.rootViewController = viewController
            })
        } else {
            window.rootViewController = viewController
        }
    }
}

