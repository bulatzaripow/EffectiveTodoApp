//
//  TodoStorageServiceMock.swift
//  EffectiveTodoAppTests
//
//  Created by Bulat Zaripov on 29.07.2025.
//

@testable import EffectiveTodoApp

final class MockStorageService: TodosStorageServiceProtocol {
    func fetchTodo(by id: Int, completion: @escaping (Todo?) -> Void) {
        
    }
    
    func fetchTodos(completion: @escaping ([Todo]) -> Void) {
        completion([
            Todo(id: 1, title: "Buy milk", completed: false),
            Todo(id: 2, title: "Read book", completed: true)
        ])
    }

    func searchTodos(by query: String, completion: @escaping ([Todo]) -> Void) {
        let todos = [
            Todo(id: 1, title: "Buy milk", completed: false),
            Todo(id: 2, title: "Read book", completed: true)
        ]
        print(query)
        print(todos)
        print(todos.filter { $0.title.contains(query) })
        completion(todos.filter { $0.title.contains(query) })
    }

    func create(completion: @escaping (Todo) -> Void) {
        completion(Todo(id: 3, title: "New todo", completed: false))
    }

    func create(todo: Todo, completion: @escaping (Todo) -> Void) {
        completion(todo)
    }
    
    func save(todo: Todo, completion: (() -> Void)?) {
        completion?()
    }
    
    func update(todo: Todo, completion: (() -> Void)?) {
        completion?()
    }
    
    func delete(todo: Todo, completion: (() -> Void)?) {
        completion?()
    }
}
