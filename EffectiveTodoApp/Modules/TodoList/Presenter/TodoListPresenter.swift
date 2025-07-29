//
//  TodoListPresenter.swift
//  EffectiveToDoApp
//
//  Created by Bulat Zaripov on 26.07.2025.
//

import Foundation

final class TodoListPresenter {
    
    // MARK: - Dependencies
    
    weak var view: TodoListViewProtocol?
    var interactor: TodoListInteractorProtocol!
    var router: TodoListRouterProtocol!
    
    // MARK: - State
    
    var todos: [Todo] = []
}

// MARK: - TodoListPresenterProtocol

extension TodoListPresenter: TodoListPresenterProtocol {
    func viewDidLoad() {
        interactor.fetchTodos()
    }
    
    func viewWillAppear() {
        interactor.fetchTodos()
        view?.updateTodoCount(todos.count)
    }
    
    func didSearchTextChange(_ text: String) {
        if text.isEmpty {
            view?.displayTodos(todos)
            view?.updateTodoCount(todos.count)
        } else {
            interactor.searchTodos(with: text)
        }
    }
    
    func didTapAddButton() {
        interactor.createTodo()
    }
    
    func didSelectTodo(_ todo: Todo) {
        router.openTodoDetail(from: view!, todo: todo)
    }
    
    func didDeleteTodo(_ todo: Todo) {
        interactor.deleteTodo(todo)
        if let index = todos.firstIndex(of: todo) {
            todos.remove(at: index)
            view?.removeTodo(with: index)
            view?.updateTodoCount(todos.count)
        }
    }
    
    func didTapCheckboxButton(for id: Int) {
        if let index = todos.firstIndex(where: { $0.id == id }) {
            var updatedTodo = todos[index]
            updatedTodo.completed.toggle()
            todos[index] = updatedTodo
            
            interactor.toggleTodoCompletion(updatedTodo)
            
            view?.displayTodos(todos)
        }
    }
}

// MARK: - TodoListInteractorOutputProtocol

extension TodoListPresenter: TodoListInteractorOutputProtocol {
    func didFetchTodos(_ todos: [Todo]) {
        self.todos = todos
        view?.displayTodos(todos)
        view?.updateTodoCount(todos.count)
    }
    
    func didSearchTodos(_ todos: [Todo]) {
        view?.displayTodos(todos)
        view?.updateTodoCount(todos.count)
    }
    
    func didCreateTodo(_ todo: Todo) {
        router.openTodoDetail(from: view!, todo: todo)
    }
}
