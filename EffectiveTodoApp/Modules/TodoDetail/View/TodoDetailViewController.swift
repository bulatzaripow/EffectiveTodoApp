//
//  TodoDetailViewController.swift
//  EffectiveTodoApp
//
//  Created by Bulat Zaripov on 27.07.2025.
//

import UIKit

final class TodoDetailViewController: UIViewController {
    var presenter: TodoDetailPresenterProtocol!
    
    // MARK: - UI
    
    private let baseView = TodoDetailView()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = baseView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Show navbar
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupActions()
        presenter.viewDidLoad()
    }
    
    private func setupUI() {
        view.backgroundColor = .appColor(.black)
        
        baseView.textView.delegate = self
    }
    
    private func setupActions() {
        baseView.titleField.addTarget(self, action: #selector(titleChanged), for: .editingChanged)
    }

    @objc private func titleChanged() {
        presenter.didUpdateTitle(baseView.titleField.text ?? "")
    }
}

// MARK: - UITextViewDelegate

extension TodoDetailViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        presenter.didUpdateText(textView.text)
    }
}

// MARK: - Configure

extension TodoDetailViewController: TodoDetailViewProtocol {
    func displayTodo(with todo: Todo) {
        baseView.setTitle(todo.title)
        baseView.setText(todo.text)
        baseView.setDate(todo.createdAt ?? Date())
    }
}
