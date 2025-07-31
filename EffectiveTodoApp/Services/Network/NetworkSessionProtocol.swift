//
//  NetworkSessionProtocol.swift
//  EffectiveTodoApp
//
//  Created by Bulat Zaripov on 30.07.2025.
//

import Foundation

protocol NetworkSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: NetworkSessionProtocol {}
