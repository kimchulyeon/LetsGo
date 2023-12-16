//
//  SceneRepository.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/17/23.
//

import UIKit
import RxSwift

class SceneRepository: SceneRepositoryProtocol {
    func getTopViewController() -> Observable<UIViewController?> {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        var nowPresentedViewController: UIViewController?
        guard let rootViewController = window?.rootViewController else { return Observable.empty() }
        nowPresentedViewController = rootViewController
        while let viewController = rootViewController.presentedViewController {
            nowPresentedViewController = viewController
        }
        
        print("현재 Top ViewController : \(nowPresentedViewController)")
        return Observable.just(nowPresentedViewController)
    }
}
