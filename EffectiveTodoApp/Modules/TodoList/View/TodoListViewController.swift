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
        baseView.searchField.addTarget(self, action: #selector(searchFieldDidChange), for: .editingChanged)
    }
}

// MARK: - Actions

@objc private extension TodoListViewController {
    func didTapAddButton() {
        presenter.didTapAddButton()
    }
    
    private func searchFieldDidChange(_ sender: UISearchTextField) {
        let text = sender.text ?? ""
        presenter.didSearchTextChange(text)
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
        cell.backgroundColor = .appColor(.black)
        
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
    
    // MARK: Context menu
    
    func tableView(_ tableView: UITableView,
                   contextMenuConfigurationForRowAt indexPath: IndexPath,
                   point: CGPoint) -> UIContextMenuConfiguration? {
        
        let todo = presenter.todos[indexPath.row]
        
        return UIContextMenuConfiguration(identifier: indexPath as NSIndexPath, previewProvider: nil) { _ in
            let editAction = UIAction(title: "Редактировать", image: UIImage(named: "edit")) { [weak self] _ in
                self?.presenter.didSelectTodo(todo)
            }
            
            let shareAction = UIAction(title: "Поделиться", image: UIImage(named: "export")) { _ in
                // TODO: share logic
            }
            
            let deleteIcon = UIImage(named: "trash")
            deleteIcon?.withTintColor(.appColor(.red))
            let deleteAction = UIAction(title: "Удалить", image: deleteIcon, attributes: .destructive) { [weak self] _ in
                self?.presenter.didDeleteTodo(todo)
            }
            
            return UIMenu(title: "", children: [editAction, shareAction, deleteAction])
        }
    }
    
    func tableView(_ tableView: UITableView,
                   willDisplayContextMenu configuration: UIContextMenuConfiguration,
                   animator: UIContextMenuInteractionAnimating?) {
        guard let indexPath = configuration.identifier as? IndexPath,
              let cell = tableView.cellForRow(at: indexPath) else { return }
        cell.backgroundColor = .appColor(.gray)
    }

    func tableView(_ tableView: UITableView,
                   willEndContextMenuInteraction configuration: UIContextMenuConfiguration,
                   animator: UIContextMenuInteractionAnimating?) {
        guard let indexPath = configuration.identifier as? IndexPath,
              let cell = tableView.cellForRow(at: indexPath) else { return }
        animator?.addAnimations {
            cell.backgroundColor = .appColor(.black)
        }
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
