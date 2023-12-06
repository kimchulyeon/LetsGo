//
//  UIView+Ext.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/6/23.
//

import UIKit

extension UIView {
    func addCornerRadius(radius: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = radius
    }
}
