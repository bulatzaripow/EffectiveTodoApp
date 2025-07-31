//
//  DateFormatterHelperTests.swift
//  EffectiveTodoAppTests
//
//  Created by Bulat Zaripov on 30.07.2025.
//

import XCTest
@testable import EffectiveTodoApp

class DateFormatterHelperTests: XCTestCase {
    
    var dateFormatterHelper: DateFormatterHelper!
    
    override func setUp() {
        // Arrange
        super.setUp()
        dateFormatterHelper = DateFormatterHelper.shared
    }
    
    func testShortFormatter_returnsCorrectDateFormat() {
        // Arrange
        let formatter = dateFormatterHelper.shortFormatter(style: .short)
        
        // Act & Assert
        XCTAssertEqual(formatter.dateFormat, "dd/MM/yy", "Date format should be dd/MM/yy")
    }
    
    func testFormat_withShortStyle_returnsFormattedDate() {
        // Arrange
        let components = DateComponents(year: 2025, month: 1, day: 15)
        let date = Calendar.current.date(from: components)!
        let formatted = dateFormatterHelper.format(date, style: .short)
        
        // Act & Assert
        XCTAssertEqual(formatted, "15/01/25", "Formatted date should match dd/MM/yy")
    }
}
