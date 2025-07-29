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
    
    private let todoNetworkService: TodoNetworkServiceProtocol
    
    // MARK: - State
    
    var todos: [Todo] = []
    
    // MARK: - Init
    
    init(todoNetworkService: TodoNetworkServiceProtocol = TodoNetworkService()) {
        self.todoNetworkService = todoNetworkService
    }
}

// MARK: - TodoListPresenterProtocol

extension TodoListPresenter: TodoListPresenterProtocol {
    func viewDidLoad() {
        interactor.fetchTodos()
        loadMockData()
    }
    
    func viewWillAppear() {
        interactor.fetchTodos()
        view?.updateTodoCount(todos.count)
    }
    
    func didSearchTextChange(_ text: String) {
        if text.isEmpty {
            interactor.fetchTodos()
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
    
    func loadMockData() {
        if !UserDefaults.standard.bool(forKey: "isFirstLaunch") {
            todoNetworkService.fetchTodos { [weak self] result in
                switch result {
                case .success(let todos):
                    self?.todos = todos
                    self?.interactor.saveTodos(todos)
                    self?.view?.displayTodos(todos)
                    self?.view?.updateTodoCount(todos.count)
                case .failure:
                    print("Ошибка загрузки задач")
                }
                UserDefaults.standard.set(true, forKey: "isFirstLaunch")
            }
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
