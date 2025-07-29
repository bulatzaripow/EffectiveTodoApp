//
//  DateFormatterHelper.swift
//  EffectiveTodoApp
//
//  Created by Bulat Zaripov on 25.07.2025.
//

import Foundation

// MARK: - Formats

enum DateFormatStyle {
    case short
}

// MARK: - Date formatter

final class DateFormatterHelper {
    static let shared = DateFormatterHelper()
    
    private init() {}
    
    func shortFormatter(style: DateFormatStyle) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        return formatter
    }
    
    func format(_ date: Date, style: DateFormatStyle) -> String {
        switch style {
        case .short:
            return shortFormatter(style: style).string(from: date)
        }
    }
}
