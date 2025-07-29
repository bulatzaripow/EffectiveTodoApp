//
//  Todo.swift
//  EffectiveTodoApp
//
//  Created by Bulat Zaripov on 25.07.2025.
//

import Foundation

struct Todo: Equatable {
    var id: Int
    var title: String
    var text: String
    var completed: Bool
    var createdAt: Date? = nil
    
    static func == (lhs: Todo, rhs: Todo) -> Bool {
        lhs.id == rhs.id
    }
}
