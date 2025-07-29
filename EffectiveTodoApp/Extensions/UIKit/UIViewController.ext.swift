//
//  UIViewController.ext.swift
//  EffectiveTodoApp
//
//  Created by Bulat Zaripov on 26.07.2025.
//

import UIKit

extension UIViewController {
    func setBackButtonTitle(_ title: String) {
        let backItem = UIBarButtonItem()
        backItem.title = title
        navigationItem.backBarButtonItem = backItem
    }
}
