//
//  PluralizerTests.swift
//  EffectiveTodoAppTests
//
//  Created by Bulat Zaripov on 30.07.2025.
//

import XCTest
@testable import EffectiveTodoApp

class PluralizerTests: XCTestCase {
    
    var pluralizer: Pluralizer!
    
    override func setUp() {
        // Arrange
        super.setUp()
        pluralizer = Pluralizer.shared
    }
    
    func testPliralizeWordWithFirstForm() {
        // Arrange
        let words = ["задача", "задачи", "задач"]
        let expected = "задача"
        
        // Act & Assert
        XCTAssertEqual(pluralizer.pluralizeWord(1, words: words), expected)
        XCTAssertEqual(pluralizer.pluralizeWord(21, words: words), expected)
        XCTAssertEqual(pluralizer.pluralizeWord(31, words: words), expected)
    }
    
    func testPliralizeWordWithSecondForm() {
        // Arrange
        let words = ["задача", "задачи", "задач"]
        let expected = "задачи"
        
        // Act & Assert
        XCTAssertEqual(pluralizer.pluralizeWord(2, words: words), expected)
        XCTAssertEqual(pluralizer.pluralizeWord(3, words: words), expected)
        XCTAssertEqual(pluralizer.pluralizeWord(4, words: words), expected)
        XCTAssertEqual(pluralizer.pluralizeWord(22, words: words), expected)
        XCTAssertEqual(pluralizer.pluralizeWord(33, words: words), expected)
        XCTAssertEqual(pluralizer.pluralizeWord(44, words: words), expected)
    }
    
    func testPliralizeWordWithThirdForm() {
        // Arrange
        let words = ["задача", "задачи", "задач"]
        let expected = "задач"
        
        // Act & Assert
        XCTAssertEqual(pluralizer.pluralizeWord(25, words: words), expected)
        XCTAssertEqual(pluralizer.pluralizeWord(30, words: words), expected)
        XCTAssertEqual(pluralizer.pluralizeWord(111, words: words), expected)
    }
}
