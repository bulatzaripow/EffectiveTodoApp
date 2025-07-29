//
//  TodoDetailProtocols.swift
//  EffectiveTodoApp
//
//  Created by Bulat Zaripov on 27.07.2025.
//

import UIKit

// MARK: - View

protocol TodoDetailViewProtocol: AnyObject {
    func displayTodo(with todo: Todo)
}

// MARK: - Presenter

protocol TodoDetailPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didUpdateTitle(_ title: String)
    func didUpdateText(_ text: String)
}

// MARK: - Interactor

protocol TodoDetailInteractorProtocol: AnyObject {
    func save(todo: Todo)
}

protocol TodoDetailInteractorOutputProtocol: AnyObject {}

// MARK: - Router

protocol TodoDetailRouterProtocol: AnyObject {
    func goBack()
}
