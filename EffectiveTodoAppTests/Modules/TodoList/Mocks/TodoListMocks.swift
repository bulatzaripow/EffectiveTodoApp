//
//  TodoListMocks.swift
//  EffectiveTodoAppTests
//
//  Created by Bulat Zaripov on 29.07.2025.
//

import UIKit
@testable import EffectiveTodoApp

// MARK: - View

final class MockViewController: UIViewController {}

final class MockTodoListView: TodoListViewProtocol {
    var receivedTodos: [Todo] = []
    var updatedCount: Int?

    func displayTodos(_ todos: [Todo]) {
        receivedTodos = todos
    }

    func updateTodoCount(_ count: Int) {
        updatedCount = count
    }

    func removeTodo(with index: Int) { }
}

// MARK: - Interactor

final class MockTodoListInteractor: TodoListInteractorProtocol {
    var didCallFetchTodos = false
    var didCallCreateTodo = false

    func fetchTodos() {
        didCallFetchTodos = true
    }

    func searchTodos(with query: String) { }

    func createTodo() {
        didCallCreateTodo = true
    }

    func deleteTodo(_ todo: Todo) { }

    func toggleTodoCompletion(_ todo: Todo) { }

    func saveTodos(_ todos: [Todo]) { }
}

final class MockTodoListInteractorOutput: TodoListInteractorOutputProtocol {
    var onDidFetchTodos: (([Todo]) -> Void)?
    var onDidCreateTodo: ((Todo) -> Void)?
    var onDidSearchTodos: (([Todo]) -> Void)?
    
    var didCallDidFetchTodos = false
    var todos: [Todo] = []

    var didCallDidCreateTodo = false
    var createdTodo: Todo?
    
    var didCallSearchTodos: Bool = false

    func didFetchTodos(_ todos: [Todo]) {
        didCallDidFetchTodos = true
        self.todos = todos
        onDidFetchTodos?(todos)
    }

    func didSearchTodos(_ todos: [Todo]) {
        didCallSearchTodos = true
        self.todos = todos
        onDidSearchTodos?(todos)
    }

    func didCreateTodo(_ todo: Todo) {
        didCallDidCreateTodo = true
        createdTodo = todo
        onDidCreateTodo?(todo)
    }
}

// MARK: - Router

final class MockTodoListRouter: TodoListRouterProtocol {
    var didCallOpenDetail = false
    var passedTodo: Todo?

    func openTodoDetail(from view: TodoListViewProtocol, todo: Todo?) {
        didCallOpenDetail = true
        passedTodo = todo
    }
}
