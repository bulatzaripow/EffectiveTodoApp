//
//  TodoNetworkProtocol.swift
//  EffectiveTodoApp
//
//  Created by Bulat Zaripov on 29.07.2025.
//

import Foundation

protocol TodoNetworkServiceProtocol {
    func fetchTodos(completion: @escaping (Result<[Todo], Error>) -> Void)
}
