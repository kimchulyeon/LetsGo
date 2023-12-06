//
//  LabelFactory.swift
//  LetsGo
//
//  Created by chulyeon kim on 12/6/23.
//

import UIKit

struct LabelFactory {
    
    enum FontWeight {
        case regular
        case demiBold
        case bold
    }
    
    // size / font / textcolor
    static func basicLabel(font: FontWeight = .regular, 
                           size: CGFloat = 16,
                           color: UIColor = ThemeColor.text) -> UILabel {
        
        let lb = UILabel()
        var labelFont = UIFont()
        switch font {
        case .regular: labelFont = ThemeFont.regular(size: size)
        case .demiBold: labelFont = ThemeFont.demiBold(size: size)
        case .bold: labelFont = ThemeFont.bold(size: size)
        }
        lb.font = labelFont
        lb.textColor = color
        return lb
    }
}

