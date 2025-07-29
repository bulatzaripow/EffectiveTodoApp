//
//  TodoListView.swift
//  EffectiveToDoApp
//
//  Created by Bulat Zaripov on 26.07.2025.
//

import UIKit

final class TodoListView: UIView {

    // MARK: - UI
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 36, weight: .bold)
        label.textColor = .white
        label.text = "Задачи"
        return label
    }()
    
    let searchField: UISearchTextField = {
        let searchFieldColor: UIColor = .appColor(.white)
        let searchField = UISearchTextField()
        searchField.font = .systemFont(ofSize: 17)
        searchField.textColor = searchFieldColor
        searchField.placeholder = "Поиск"
        
        // Placeholder
        let placeholder = searchField.value(forKey: "placeholderLabel") as? UILabel
        placeholder?.textColor = searchFieldColor.withAlphaComponent(0.5)
        
        // Glass icon
        let glassIcon = searchField.leftView as? UIImageView
        glassIcon?.tintColor = searchFieldColor.withAlphaComponent(0.5)
        
        // Clear button
        if let clearButton = searchField.value(forKey: "clearButton") as? UIButton,
           let image = clearButton.image(for: .normal) {
            let tintedImage = image.withRenderingMode(.alwaysTemplate)
            clearButton.setImage(tintedImage, for: .normal)
            clearButton.tintColor = searchFieldColor.withAlphaComponent(0.5)
        }
        
        return searchField
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.keyboardDismissMode = .onDrag
        tableView.register(TodoCell.self, forCellReuseIdentifier: "TodoCell")
        tableView.backgroundColor = .clear
        tableView.separatorColor = .appColor(.stroke)
        return tableView
    }()
    
    let bottomBar: UIView = {
        let view = UIView()
        view.backgroundColor = .appColor(.gray)
        return view
    }()
    
    let bottomBarInnerContainer = UIView()
    
    let taskCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.textColor = .appColor(.white)
        label.textAlignment = .center
        return label
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        button.tintColor = .appColor(.yellow)
        return button
    }()

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    
    private func setupUI() {
        backgroundColor = .systemBackground

        addSubview(titleLabel)
        addSubview(searchField)
        addSubview(tableView)
        addSubview(bottomBar)
        
        bottomBar.addSubview(bottomBarInnerContainer)
        bottomBarInnerContainer.addSubview(taskCountLabel)
        bottomBarInnerContainer.addSubview(addButton)
    }
    
    private func setupConstraints() {
        [
            titleLabel,
            searchField,
            tableView,
            bottomBar,
            bottomBarInnerContainer,
            taskCountLabel,
            addButton
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            // Title
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            // Search bar
            searchField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            searchField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            searchField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            // TableView
            tableView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: bottomBar.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),

            // Bottom bar
            bottomBar.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomBar.heightAnchor.constraint(equalToConstant: 83),
            
            // Bottom bar inner container
            bottomBarInnerContainer.topAnchor.constraint(equalTo: bottomBar.topAnchor),
            bottomBarInnerContainer.leadingAnchor.constraint(equalTo: bottomBar.leadingAnchor),
            bottomBarInnerContainer.trailingAnchor.constraint(equalTo: bottomBar.trailingAnchor),
            bottomBarInnerContainer.heightAnchor.constraint(equalToConstant: 49),

            // Task count label
            taskCountLabel.centerXAnchor.constraint(equalTo: bottomBarInnerContainer.centerXAnchor),
            taskCountLabel.centerYAnchor.constraint(equalTo: bottomBarInnerContainer.centerYAnchor),

            // Add button
            addButton.centerYAnchor.constraint(equalTo: bottomBarInnerContainer.centerYAnchor),
            addButton.trailingAnchor.constraint(equalTo: bottomBar.trailingAnchor, constant: -16),
            addButton.heightAnchor.constraint(equalToConstant: 30),
            addButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
}
