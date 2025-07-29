//
//  TodosResponse.swift
//  EffectiveTodoApp
//
//  Created by Bulat Zaripov on 29.07.2025.
//

import Foundation

struct TodosResponse: Decodable {
    let todos: [Todo]
    let total: Int
    let skip: Int
    let limit: Int
}
