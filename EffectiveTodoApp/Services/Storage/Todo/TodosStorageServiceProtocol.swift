//
//  TodosStorageServiceProtocol.swift
//  EffectiveTodoApp
//
//  Created by Bulat Zaripov on 25.07.2025.
//

import Foundation

protocol TodosStorageServiceProtocol: AnyObject {
    func fetchTodo(by id: Int, completion: @escaping (Todo?) -> Void)
    func fetchTodos(completion: @escaping ([Todo]) -> Void)
    func searchTodos(by query: String, completion: @escaping ([Todo]) -> Void)
    func create(completion: @escaping (Todo) -> Void)
    func save(todo: Todo, completion: (() -> Void)?)
    func update(todo: Todo, completion: (() -> Void)?)
    func delete(todo: Todo, completion: (() -> Void)?)
}
