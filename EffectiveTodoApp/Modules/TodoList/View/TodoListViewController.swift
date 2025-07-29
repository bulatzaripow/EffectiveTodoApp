//
//  TodoListViewController.swift
//  EffectiveToDoApp
//
//  Created by Bulat Zaripov on 26.07.2025.
//

import UIKit

final class TodoListViewController: UIViewController {
    var presenter: TodoListPresenterProtocol!
    
    // MARK: - UI
    
    private let baseView = TodoListView()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = baseView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
        
        // Hide navbar
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.viewDidLoad()
        setBackButtonTitle("Назад")
    }
    
    private func setupUI() {
        view.backgroundColor = .appColor(.black)

        baseView.tableView.dataSource = self
        baseView.tableView.delegate = self
        
        setupActions()
    }
    
    private func setupActions() {
        baseView.addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
    }
}

// MARK: - Actions

@objc private extension TodoListViewController {
    func didTapAddButton() {
        presenter.didTapAddButton()
    }
}

// MARK: - UITableViewDataSource

extension TodoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.todos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as? TodoCell else {
            return UITableViewCell()
        }
        
        let todo = presenter.todos[indexPath.row]
        
        cell.configure(with: presenter.todos[indexPath.row])
        cell.selectionStyle = .none
        
        cell.onCheckboxTapped = { [weak self] in
            guard let self = self else { return }
            self.presenter.didTapCheckboxButton(for: todo.id)
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension TodoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = presenter.todos[indexPath.row]
        presenter.didSelectTodo(todo)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let todo = presenter.todos[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive,
                                              title: "Удалить") { [weak self] _, _, completion in
            self?.presenter.didDeleteTodo(todo)
            completion(true)
        }

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

// MARK: - TodoListViewProtocol

extension TodoListViewController: TodoListViewProtocol {
    func displayTodos(_ todos: [Todo]) {
        baseView.tableView.reloadData()
    }

    func updateTodoCount(_ count: Int) {
        let countString = Pluralizer.shared.pluralizeWord(count, words: ["Задача", "Задачи", "Задач"])
        baseView.taskCountLabel.text = "\(count) \(countString)"
    }
    
    func removeTodo(with index: Int) {
        baseView.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
}
