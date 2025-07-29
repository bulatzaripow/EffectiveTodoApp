//
//  TodoListInteractor.swift
//  EffectiveToDoApp
//
//  Created by Bulat Zaripov on 26.07.2025.
//

import Foundation

final class TodoListInteractor {
    weak var presenter: TodoListInteractorOutputProtocol?
    var storageService: TodosStorageServiceProtocol!
}

// MARK: - TodoListInteractorProtocol

extension TodoListInteractor: TodoListInteractorProtocol {
    func createTodo() {
        storageService.create { [weak self] todo in
            DispatchQueue.main.async {
                self?.presenter?.didCreateTodo(todo)
            }
        }
    }
    
    func fetchTodos() {
        storageService.fetchTodos { [weak self] todos in
            DispatchQueue.main.async {
                self?.presenter?.didFetchTodos(todos)
            }
        }
    }

    func searchTodos(with query: String) {
        storageService.searchTodos(by: query) { [weak self] todos in
            DispatchQueue.main.async {
                self?.presenter?.didFetchTodos(todos)
            }
        }
    }
    
    func deleteTodo(_ todo: Todo) {
        storageService.delete(todo: todo, completion: nil)
    }
    
    func toggleTodoCompletion(_ todo: Todo) {
        storageService.update(todo: todo, completion: nil)
    }
}
