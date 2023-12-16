//
//  SceneRepositoryProtocol.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/17/23.
//

import UIKit
import RxSwift

protocol SceneRepositoryProtocol {
    func getTopViewController() -> Observable<UIViewController?>
}
