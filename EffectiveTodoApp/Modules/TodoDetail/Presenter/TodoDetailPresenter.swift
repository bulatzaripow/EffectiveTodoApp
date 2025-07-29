//
//  TodoDetailPresenter.swift
//  EffectiveTodoApp
//
//  Created by Bulat Zaripov on 27.07.2025.
//

final class TodoDetailPresenter {
    weak var view: TodoDetailViewProtocol?
    var interactor: TodoDetailInteractorProtocol!
    var router: TodoDetailRouterProtocol!

    private var todo: Todo

    init(todo: Todo?) {
        // TODO: replace with TodoStorageService create if todo is nil
        self.todo = todo ?? Todo(id: 1, title: "", text: "", completed: false)
    }
}

extension TodoDetailPresenter: TodoDetailPresenterProtocol {
    func viewDidLoad() {
        view?.displayTodo(with: self.todo)
    }

    func didUpdateTitle(_ title: String) {
        todo.title = title
        interactor.save(todo: todo)
    }

    func didUpdateText(_ text: String) {
        todo.text = text
        interactor.save(todo: todo)
    }
}
