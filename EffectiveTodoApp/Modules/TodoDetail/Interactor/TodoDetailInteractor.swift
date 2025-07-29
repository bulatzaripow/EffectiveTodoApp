//
//  TodoDetailInteractor.swift
//  EffectiveTodoApp
//
//  Created by Bulat Zaripov on 27.07.2025.
//

final class TodoDetailInteractor {
    var storageService: TodosStorageServiceProtocol!
}

extension TodoDetailInteractor: TodoDetailInteractorProtocol {
    func save(todo: Todo) {
        storageService.save(todo: todo) {}
    }
}
