//
//  TodosStorageService.swift
//  EffectiveTodoApp
//
//  Created by Bulat Zaripov on 25.07.2025.
//

import CoreData

final class TodosStorageService: TodosStorageServiceProtocol {
    private let context: NSManagedObjectContext
    private let backgroundContext: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = CoreDataManager.shared.context) {
        self.context = context
        self.backgroundContext = CoreDataManager.shared.persistentContainer.newBackgroundContext()
    }
    
    func fetchTodo(by id: Int, completion: @escaping (Todo?) -> Void) {
        backgroundContext.perform {
            let request: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
            
            request.predicate = NSPredicate(format: "id == %d", id)
            
            do {
                let result = try self.backgroundContext.fetch(request).first.map { Todo(entity: $0) }
                DispatchQueue.main.async {
                    completion(result)
                }
            } catch {
                print("Fetch by id error: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }

    func fetchTodos(completion: @escaping ([Todo]) -> Void) {
        backgroundContext.perform {
            let request: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
            
            let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: false)
            request.sortDescriptors = [sortDescriptor]
            
            do {
                let entities = try self.backgroundContext.fetch(request)
                let todos = entities.map { Todo(entity: $0) }
                DispatchQueue.main.async {
                    completion(todos)
                }
            } catch {
                print("Fetch error: \(error)")
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }
    }
    
    func searchTodos(by query: String, completion: @escaping ([Todo]) -> Void) {
        backgroundContext.perform {
            let request: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
            
            request.predicate = NSCompoundPredicate(orPredicateWithSubpredicates: [
                NSPredicate(format: "title CONTAINS[cd] %@", query),
                NSPredicate(format: "text CONTAINS[cd] %@", query)
            ])
            
            let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: false)
            request.sortDescriptors = [sortDescriptor]
            
            do {
                let results = try self.backgroundContext.fetch(request)
                let todos = results.map { Todo(entity: $0) }
                DispatchQueue.main.async {
                    completion(todos)
                }
            } catch {
                print("Search error: \(error)")
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }
    }
    
    func create(completion: @escaping (Todo) -> Void) {
        backgroundContext.perform {
            let entity = TodoEntity(context: self.backgroundContext)
            entity.id = Int64(self.generateNextID())
            entity.title = ""
            entity.text = ""
            entity.completed = false
            entity.createdAt = Date()
            
            do {
                try self.backgroundContext.save()
                let todo = Todo(entity: entity)
                DispatchQueue.main.async {
                    completion(todo)
                }
            } catch {
                print("Error saving empty todo: \(error)")
                DispatchQueue.main.async {
                    completion(Todo())
                }
            }
        }
    }
    
    func create(todo: Todo, completion: @escaping (Todo) -> Void) {
        backgroundContext.perform {
            let entity = TodoEntity(context: self.backgroundContext)
            entity.id = Int64(todo.id)
            entity.title = todo.title
            entity.text = todo.text
            entity.completed = todo.completed
            entity.createdAt = todo.createdAt
            
            do {
                try self.backgroundContext.save()
                let todo = Todo(entity: entity)
                DispatchQueue.main.async {
                    completion(todo)
                }
            } catch {
                print("Error saving empty todo: \(error)")
                DispatchQueue.main.async {
                    completion(Todo())
                }
            }
        }
    }

    func save(todo: Todo, completion: (() -> Void)? = nil) {
        backgroundContext.perform {
            let request: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %d", todo.id)
            
            do {
                if let existing = try self.backgroundContext.fetch(request).first {
                    existing.configure(with: todo)
                    if existing.id == 0 {
                        existing.id = Int64(self.generateNextID())
                    }
                } else {
                    let newEntity = TodoEntity(context: self.backgroundContext)
                    newEntity.configure(with: todo)
                }
                try self.backgroundContext.save()
            } catch {
                print("Save error: \(error)")
            }
            
            if let completion = completion {
                DispatchQueue.main.async { completion() }
            }
        }
    }

    func delete(todo: Todo, completion: (() -> Void)? = nil) {
        backgroundContext.perform {
            let request: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
            
            request.predicate = NSPredicate(format: "id == %d", todo.id)
            
            do {
                if let entity = try self.backgroundContext.fetch(request).first {
                    self.backgroundContext.delete(entity)
                    try self.backgroundContext.save()
                }
            } catch {
                print("Delete error: \(error)")
            }
            
            if let completion = completion {
                DispatchQueue.main.async { completion() }
            }
        }
    }

    func update(todo: Todo, completion: (() -> Void)? = nil) {
        backgroundContext.perform {
            let request: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
            
            request.predicate = NSPredicate(format: "id == %d", todo.id)
            
            do {
                if let entity = try self.backgroundContext.fetch(request).first {
                    entity.configure(with: todo)
                    try self.backgroundContext.save()
                }
            } catch {
                print("Update error: \(error)")
            }
            
            if let completion = completion {
                DispatchQueue.main.async { completion() }
            }
        }
    }
    
    private func generateNextID() -> Int {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "TodoEntity")
        
        request.resultType = .dictionaryResultType
        request.propertiesToFetch = ["id"]
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        request.fetchLimit = 1

        do {
            if let result = try backgroundContext.fetch(request).first as? [String: Int],
               let maxID = result["id"] {
                return maxID + 1
            }
        } catch {
            print("Failed to fetch max ID: \(error)")
        }

        return 1
    }
}
