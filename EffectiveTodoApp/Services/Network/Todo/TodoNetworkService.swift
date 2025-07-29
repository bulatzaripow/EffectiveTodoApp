//
//  TodoNetworkService.swift
//  EffectiveTodoApp
//
//  Created by Bulat Zaripov on 29.07.2025.
//

import Foundation

final class TodoNetworkService: TodoNetworkServiceProtocol {
    private let url = URL(string: "https://dummyjson.com/todos")!
        
    func fetchTodos(completion: @escaping (Result<[Todo], Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let data = data else {
                // TODO: NetworkError
                return
            }
            
            do {
                let result = try JSONDecoder().decode(TodosResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result.todos))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
