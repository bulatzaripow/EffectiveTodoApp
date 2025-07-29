//
//  TodoDetailRouter.swift
//  EffectiveTodoApp
//
//  Created by Bulat Zaripov on 27.07.2025.
//

import UIKit

final class TodoDetailRouter {
    weak var view: UIViewController?
}

extension TodoDetailRouter: TodoDetailRouterProtocol {
    func goBack() {
        self.view?.navigationController?.popViewController(animated: true)
    }
}
