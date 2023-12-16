//
//  ThemeFont.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/6/23.
//

import UIKit

struct ThemeFont {
    static func regular(size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-Regular", size: size) ?? .systemFont(ofSize: size)
    }

    static func bold(size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-Bold", size: size) ?? .systemFont(ofSize: size)
    }

    static func demiBold(size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-DemiBold", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func customBold(size: CGFloat) -> UIFont {
        return UIFont(name: "KIMM_Bold", size: size)!
    }
    
    static func customLight(size: CGFloat) -> UIFont {
        return UIFont(name: "KIMM_Light", size: size)!
    }
}


