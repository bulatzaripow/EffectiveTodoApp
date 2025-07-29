//
//  TodoListProtocols.swift
//  EffectiveToDoApp
//
//  Created by Bulat Zaripov on 26.07.2025.
//

import UIKit

// MARK: - View

protocol TodoListViewProtocol: AnyObject {
    func displayTodos(_ todos: [Todo])
    func updateTodoCount(_ count: Int)
    func removeTodo(with index: Int)
}

// MARK: - Presenter

protocol TodoListPresenterProtocol: AnyObject {
    var todos: [Todo] { get set }
    
    func viewWillAppear()
    func viewDidLoad()
    func didSearchTextChange(_ text: String)
    func didTapAddButton()
    func didSelectTodo(_ todo: Todo)
    func didDeleteTodo(_ todo: Todo)
    func didTapCheckboxButton(for id: Int)
}

// MARK: - Interactor

protocol TodoListInteractorProtocol: AnyObject {
    func fetchTodos()
    func searchTodos(with query: String)
    func createTodo()
    func deleteTodo(_ todo: Todo)
    func toggleTodoCompletion(_ todo: Todo)
}

protocol TodoListInteractorOutputProtocol: AnyObject {
    func didFetchTodos(_ todos: [Todo])
    func didSearchTodos(_ todos: [Todo])
    func didCreateTodo(_ todo: Todo)
}

// MARK: - Router

protocol TodoListRouterProtocol: AnyObject {
    func openTodoDetail(from view: TodoListViewProtocol, todo: Todo?)
}
