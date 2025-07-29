//
//  TodoDetailBuilder.swift
//  EffectiveTodoApp
//
//  Created by Bulat Zaripov on 27.07.2025.
//

import UIKit

final class TodoDetailBuilder {
    static func build(with todo: Todo?) -> UIViewController {
        let view = TodoDetailViewController()
        let presenter = TodoDetailPresenter(todo: todo)
        let interactor = TodoDetailInteractor()
        let router = TodoDetailRouter()
        let storageService = TodosStorageService()

        view.presenter = presenter

        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router

        interactor.storageService = storageService
        
        router.view = view

        return view
    }
}
