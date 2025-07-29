//
//  UIColor.swift
//  EffectiveTodoApp
//
//  Created by Bulat Zaripov on 25.07.2025.
//

import UIKit

extension UIColor {
    enum AppColor: String {
        case white = "AppWhite"
        case black = "AppBlack"
        case stroke = "AppStroke"
        case gray = "AppGray"
        case lightGray = "AppLightGray"
        case yellow = "AppYellow"
        case red = "AppRed"
    }
    
    static func appColor(_ color: AppColor) -> UIColor {
        return .init(named: color.rawValue) ?? fallbackColor(for: color)
    }
    
    private static func fallbackColor(for color: AppColor) -> UIColor {
        print("Can't find \(color.rawValue) color")
        
        switch color {
        case .white:
            return .white
        case .black:
            return .black
        case .stroke:
            return .black
        case .gray:
            return .gray
        case .lightGray:
            return .lightGray
        case .yellow:
            return .yellow
        case .red:
            return .red
        }
    }
}
