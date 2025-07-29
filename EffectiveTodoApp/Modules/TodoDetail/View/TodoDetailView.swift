//
//  TodoDetailView.swift
//  EffectiveTodoApp
//
//  Created by Bulat Zaripov on 27.07.2025.
//

import UIKit

final class TodoDetailView: UIView {
    
    // MARK: - UI
    
    let titleField: UITextField = {
        let title = UITextField()
        title.font = .systemFont(ofSize: 34, weight: .bold)
        title.textColor = .appColor(.white)
        title.placeholder = "Заголовок"
        return title
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .appColor(.white).withAlphaComponent(0.5)
        label.numberOfLines = 1
        return label
    }()
    
    let textView: UITextView = {
        let view = UITextView()
        view.textContainerInset = .zero
        view.textContainer.lineFragmentPadding = 20
        view.font = .systemFont(ofSize: 16, weight: .regular)
        view.textColor = .appColor(.white)
        view.backgroundColor = .clear
        return view
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
        addSubview(titleField)
        addSubview(dateLabel)
        addSubview(textView)
    }
    
    private func setupConstraints() {
        [
            titleField,
            textView,
            dateLabel
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            // Title
            titleField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 9),
            titleField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            // Date label
            dateLabel.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 9),
            dateLabel.leadingAnchor.constraint(equalTo: titleField.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: titleField.trailingAnchor),

            // Text view
            textView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}

// MARK: - Configure

extension TodoDetailView {
    func setTitle(_ title: String) {
        let attributedString = NSMutableAttributedString(string: title)
        let paragraphStyle = NSMutableParagraphStyle()
        attributedString.addAttributes([
            .kern: 0.8,
            .paragraphStyle: paragraphStyle,
            .font: UIFont.systemFont(ofSize: 34, weight: .bold)
        ], range: NSRange(location: 0, length: title.count))
        titleField.attributedText = attributedString
    }
    
    func setText(_ text: String) {
        let attributedString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attributedString.addAttributes([
            .kern: 0.3,
            .paragraphStyle: paragraphStyle,
            .font: UIFont.systemFont(ofSize: 16, weight: .regular)
        ], range: NSRange(location: 0, length: text.count))

        textView.attributedText = attributedString
        textView.textColor = .appColor(.white)
    }
    
    func setDate(_ date: Date) {
        dateLabel.text = DateFormatterHelper.shared.format(date, style: .short)
    }
}
