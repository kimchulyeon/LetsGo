//
//  GoogleLoginRepositoryProtocol.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/17/23.
//

import UIKit
import RxSwift

protocol GoogleLoginRepositoryProtocol {
    func authenticate(at vc: UIViewController?) -> Observable<User?>
}
