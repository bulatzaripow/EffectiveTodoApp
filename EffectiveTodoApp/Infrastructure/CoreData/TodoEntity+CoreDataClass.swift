//
//  TodoEntity+CoreDataClass.swift
//  EffectiveTodoApp
//
//  Created by Bulat Zaripov on 25.07.2025.
//
//

import Foundation
import CoreData

@objc(TodoEntity)
public class TodoEntity: NSManagedObject {
    func configure(with todo: Todo) {
        self.id = Int64(todo.id)
        self.title = todo.title
        self.text = todo.text
        self.completed = todo.completed
        self.createdAt = todo.createdAt
    }
}
