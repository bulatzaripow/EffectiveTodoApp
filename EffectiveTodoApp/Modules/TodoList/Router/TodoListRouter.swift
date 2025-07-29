//
//  TodoListRouter.swift
//  EffectiveToDoApp
//
//  Created by Bulat Zaripov on 26.07.2025.
//

import UIKit

final class TodoListRouter: TodoListRouterProtocol {
    weak var view: UIViewController?

    func openTodoDetail(from view: any TodoListViewProtocol, todo: Todo?) {
        // TODO: open todo detail
    }
}
