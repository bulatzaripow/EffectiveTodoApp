//
//  TodoNetworkService.swift
//  EffectiveTodoApp
//
//  Created by Bulat Zaripov on 29.07.2025.
//

import Foundation

final class TodoNetworkService: TodoNetworkServiceProtocol {
    private let url: URL
    private let session: NetworkSessionProtocol
    
    init(url: URL, session: NetworkSessionProtocol = URLSession.shared) {
        self.url = url
        self.session = session
    }
        
    func fetchTodos(completion: @escaping (Result<[Todo], Error>) -> Void) {
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.noData))
                }
                return
            }
            
            do {
                let result = try JSONDecoder().decode(TodosResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result.todos))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.decodingError(error)))
                }
            }
        }.resume()
    }
}
