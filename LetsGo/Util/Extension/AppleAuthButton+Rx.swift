//
//  AppleAuthButton+Rx.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/15/23.
//

import AuthenticationServices
import RxSwift
import RxCocoa

extension Reactive where Base: ASAuthorizationAppleIDButton {
    var tap: ControlEvent<Void> {
        let source = self.controlEvent(.touchUpInside)
        return ControlEvent(events: source)
    }
}

