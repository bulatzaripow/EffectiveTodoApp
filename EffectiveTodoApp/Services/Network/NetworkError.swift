//
//  NetworkError.swift
//  EffectiveTodoApp
//
//  Created by Bulat Zaripov on 31.07.2025.
//

import Foundation

enum NetworkError: LocalizedError {
    case noData
    case invalidResponse
    case decodingError(Error)

    var errorDescription: String? {
        switch self {
        case .noData:
            return "Нет данных от сервера"
        case .invalidResponse:
            return "Некорректный ответ сервера"
        case .decodingError(let error):
            return "Ошибка декодирования: \(error.localizedDescription)"
        }
    }
}

