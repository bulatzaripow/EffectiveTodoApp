//
//  Pluralizer.swift
//  EffectiveTodoApp
//
//  Created by Bulat Zaripov on 28.07.2025.
//

import Foundation

final class Pluralizer {
    static let shared = Pluralizer()
    private init() {}
    
    func pluralizeWord(_ number: Int, words: [String]) -> String {
        // order: ["год", "года", "лет"]
        switch number % 10 {
        case 1 where number % 100 != 11: return words[0]
        case 2...4 where !(12...14).contains(number % 100): return words[1]
        default: return words[2]
        }
    }
}
