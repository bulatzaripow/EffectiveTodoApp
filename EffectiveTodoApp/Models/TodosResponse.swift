//
//  TodosResponse.swift
//  EffectiveTodoApp
//
//  Created by Bulat Zaripov on 29.07.2025.
//

import Foundation

struct TodosResponse: Codable {
    let todos: [Todo]
    let total: Int
    let skip: Int
    let limit: Int
    
    init(todos: [Todo], total: Int = 0, skip: Int = 0, limit: Int = 0) {
        self.todos = todos
        self.total = total
        self.skip = skip
        self.limit = limit
    }
}
