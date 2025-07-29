//
//  Todo.swift
//  EffectiveTodoApp
//
//  Created by Bulat Zaripov on 25.07.2025.
//

import Foundation

struct Todo: Equatable, Decodable {
    var id: Int
    var title: String
    var text: String
    var completed: Bool
    var createdAt: Date? = nil
    
    static func == (lhs: Todo, rhs: Todo) -> Bool {
        lhs.id == rhs.id
    }
    
    init(
        id: Int = 0,
        title: String = "",
        text: String = "",
        completed: Bool = false
    ) {
         self.id = id
         self.title = title
         self.text = text
         self.completed = completed
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case todo
        case completed
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try Int(container.decode(Int.self, forKey: .id))
        self.title = try container.decode(String.self, forKey: .todo)
        self.completed = try container.decode(Bool.self, forKey: .completed)
        
        self.text = ""
        self.createdAt = Date()
    }
}

extension Todo {
    init(entity: TodoEntity) {
        self.id = Int(entity.id)
        self.title = entity.title ?? ""
        self.text = entity.text ?? ""
        self.completed = entity.completed
        self.createdAt = entity.createdAt
    }
}
