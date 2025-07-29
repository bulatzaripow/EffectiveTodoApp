//
//  TodoEntity+CoreDataProperties.swift
//  EffectiveTodoApp
//
//  Created by Bulat Zaripov on 25.07.2025.
//
//

import Foundation
import CoreData


extension TodoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoEntity> {
        return NSFetchRequest<TodoEntity>(entityName: "TodoEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var text: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var completed: Bool

}

extension TodoEntity : Identifiable {
}
