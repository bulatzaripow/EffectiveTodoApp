//
//  TodoNetworkServiceTests.swift
//  EffectiveTodoAppTests
//
//  Created by Bulat Zaripov on 31.07.2025.
//

import XCTest
import Foundation
@testable import EffectiveTodoApp

final class TodoNetworkServiceTests: XCTestCase {
    var service: TodoNetworkService!
    let testURL = URL(string: "https://example.com/todos")!

    override func setUp() {
        super.setUp()
        let session = makeMockedSession()
        service = TodoNetworkService(url: testURL, session: session)
    }

    override func tearDown() {
        super.tearDown()
        MockURLProtocol.testData = nil
        MockURLProtocol.response = nil
        MockURLProtocol.error = nil
    }
    
    private func makeMockedSession() -> URLSession {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: config)
    }

    func testFetchTodosSuccess() {
        // Arrange
        let todos: [[String: Any]] = [
            ["id": 1, "todo": "Test 1", "completed": false],
            ["id": 2, "todo": "Test 2", "completed": true]
        ]
        let json: [String: Any] = [
            "todos": todos,
            "total": 2,
            "skip": 0,
            "limit": 0
        ]
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])

        MockURLProtocol.testData = jsonData
        MockURLProtocol.response = HTTPURLResponse(url: testURL, statusCode: 200, httpVersion: nil, headerFields: nil)

        let expectation = expectation(description: "Todos fetched")

        // Act
        service.fetchTodos { result in
            // Assert
            switch result {
            case .success(let todos):
                XCTAssertEqual(todos.count, 2)
                XCTAssertEqual(todos[0].title, "Test 1")
            case .failure(let error):
                XCTFail("Expected success, got error: \(error)")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchTodosFailureInvalidJSON() {
        // Arrange
        MockURLProtocol.testData = Data("invalid json".utf8)
        MockURLProtocol.response = HTTPURLResponse(url: testURL, statusCode: 200, httpVersion: nil, headerFields: nil)

        let expectation = expectation(description: "Decoding failed")

        // Act
        service.fetchTodos { result in
            // Assert
            switch result {
            case .success:
                XCTFail("Expected decoding error")
            case .failure(let error):
                switch error {
                case NetworkError.decodingError(let decodingError):
                    XCTAssertTrue(decodingError is DecodingError)
                default:
                    XCTFail("Expected NetworkError.decodingError, got: \(error)")
                }
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchTodosFailureNetworkError() {
        // Arrange
        let expectedError = NSError(domain: "TestError", code: 123, userInfo: nil)
        MockURLProtocol.error = expectedError

        let expectation = expectation(description: "Network error")

        // Act
        service.fetchTodos { result in
            // Assert
            switch result {
            case .success:
                XCTFail("Expected network error")
            case .failure(let error as NSError):
                XCTAssertEqual(error.domain, "TestError")
                XCTAssertEqual(error.code, 123)
            default:
                XCTFail("Unexpected error type")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
}
