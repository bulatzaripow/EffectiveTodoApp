//
//  TodoCell.swift
//  EffectiveToDoApp
//
//  Created by Bulat Zaripov on 26.07.2025.
//

import UIKit

final class TodoCell: UITableViewCell {
    
    // MARK: - Properties
    
    var onCheckboxTapped: (() -> Void)?
    
    // MARK: - UI
    
    private let checkboxButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.appColor(.stroke).cgColor
        button.clipsToBounds = true
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .appColor(.white)
        label.numberOfLines = 1
        return label
    }()
    
    private let textLabelView: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .appColor(.white)
        label.numberOfLines = 2
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .appColor(.white).withAlphaComponent(0.5)
        label.numberOfLines = 1
        return label
    }()
    
    private let labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.alignment = .leading
        return stackView
    }()

    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configure
    
    func configure(with todo: Todo) {
        updateTitleLabel(with: todo.title)
        updateTextLabel(with: todo.text)
        updateDateLabel(with: todo.createdAt)
        updateCompleted(todo.completed)
    }
}

// MARK: - UI setup

private extension TodoCell {
    func setupUI() {
        backgroundColor = .clear
        
        contentView.layoutMargins = UIEdgeInsets(top: 12, left: 0, bottom: 14, right: 0)

        contentView.addSubview(checkboxButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(textLabelView)
        contentView.addSubview(dateLabel)

        setupConstraints()
    }
    
    func setupActions() {
        checkboxButton.addTarget(self, action: #selector(didTapCheckbox), for: .touchUpInside)
    }

    func setupConstraints() {
        checkboxButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabelView.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let margins = contentView.layoutMarginsGuide

        NSLayoutConstraint.activate([
            // Checkbox button
            checkboxButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            checkboxButton.topAnchor.constraint(equalTo: margins.topAnchor),
            checkboxButton.widthAnchor.constraint(equalToConstant: 24),
            checkboxButton.heightAnchor.constraint(equalToConstant: 24),
            
            // Title
            titleLabel.topAnchor.constraint(equalTo: margins.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: checkboxButton.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Text
            textLabelView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 9),
            textLabelView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            textLabelView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            // Date
            dateLabel.topAnchor.constraint(equalTo: textLabelView.bottomAnchor, constant: 9),
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            dateLabel.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
        ])
    }
}

// MARK: - UI update

private extension TodoCell {
    func updateTitleLabel(with text: String) {
        titleLabel.text = text
    }
    
    func updateTextLabel(with text: String) {
        let attributedString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attributedString.addAttributes([
            .kern: 0.3,
            .paragraphStyle: paragraphStyle
        ], range: NSRange(location: 0, length: text.count))

        textLabelView.attributedText = attributedString
    }
    
    func updateDateLabel(with date: Date?) {
        dateLabel.text = DateFormatterHelper.shared.format(date ?? Date(), style: .short)
    }
    
    func updateCompleted(_ completed: Bool) {
        if completed {
            checkboxButton.layer.borderColor = UIColor.appColor(.yellow).cgColor
            checkboxButton.setImage(
                UIImage(named: "check")?.withTintColor(.appColor(.yellow)),
                for: .normal
            )
            
            titleLabel.textColor = .appColor(.white).withAlphaComponent(0.5)
            textLabelView.textColor = .appColor(.white).withAlphaComponent(0.5)
            
            let attributedText = NSAttributedString(
                string: titleLabel.text ?? "",
                attributes: [
                    .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                    .strikethroughColor: UIColor.appColor(.white).withAlphaComponent(0.5)
                ]
            )
            titleLabel.attributedText = attributedText
        } else {
            let title = titleLabel.text ?? ""
            titleLabel.attributedText = nil
            titleLabel.text = title
            titleLabel.textColor = .appColor(.white)
            
            textLabelView.textColor = .appColor(.white)
            
            checkboxButton.setImage(nil, for: .normal)
            checkboxButton.layer.borderColor = UIColor.appColor(.stroke).cgColor
        }
    }
}

// MARK: - Actions

@objc private extension TodoCell {
    func didTapCheckbox() {
        self.onCheckboxTapped?()
    }
}
