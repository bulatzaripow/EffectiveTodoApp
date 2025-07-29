//
//  AppCoordinator.swift
//  EffectiveTodoApp
//
//  Created by Bulat Zaripov on 26.07.2025.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    func start()
}

final class AppCoordinator: Coordinator {
    private let window: UIWindow
    var navigationController: UINavigationController
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start() {
        let vc = ViewController()
        navigationController.setViewControllers( [vc], animated: false)
        
        UINavigationBar.appearance().tintColor = .appColor(.yellow)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
