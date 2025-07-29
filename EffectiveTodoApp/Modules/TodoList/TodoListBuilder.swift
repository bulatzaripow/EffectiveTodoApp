//
//  TaskListBuilder.swift
//  EffectiveToDoApp
//
//  Created by Bulat Zaripov on 26.07.2025.
//

import UIKit

final class TodoListBuilder {
    static func build() -> UIViewController {
        let view = TodoListViewController()
        let presenter = TodoListPresenter()
        let interactor = TodoListInteractor()
        let router = TodoListRouter()
        let storageService = TodosStorageService()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.storageService = storageService
        interactor.presenter = presenter
        
        router.view = view

        return view
    }
}
