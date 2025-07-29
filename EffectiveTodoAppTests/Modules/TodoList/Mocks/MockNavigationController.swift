//
//  MockNavigationController.swift
//  EffectiveTodoAppTests
//
//  Created by Bulat Zaripov on 29.07.2025.
//

import UIKit

final class MockNavigationController: UINavigationController {
    var didPushViewController = false
    var pushedViewController: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        didPushViewController = true
        pushedViewController = viewController
        super.pushViewController(viewController, animated: animated)
    }
}
