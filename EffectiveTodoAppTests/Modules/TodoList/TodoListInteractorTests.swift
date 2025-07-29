//
//  TodoListInteractorTests.swift
//  EffectiveTodoAppTests
//
//  Created by Bulat Zaripov on 29.07.2025.
//

import XCTest
@testable import EffectiveTodoApp

final class TodoListInteractorTests: XCTestCase {

    private var interactor: TodoListInteractor!
    private var mockPresenter: MockTodoListInteractorOutput!
    private var mockStorage: MockStorageService!

    override func setUp() {
        super.setUp()
        
        // Arrange
        interactor = TodoListInteractor()
        mockPresenter = MockTodoListInteractorOutput()
        mockStorage = MockStorageService()

        interactor.presenter = mockPresenter
        interactor.storageService = mockStorage
    }

    func testFetchTodosCallsPresenterWithTodos() {
        // Arrange
        let expectation = self.expectation(description: "Fetch todos")
        
        mockPresenter.onDidFetchTodos = { todos in
            expectation.fulfill()
        }
        
        // Act
        interactor.fetchTodos()
        
        waitForExpectations(timeout: 1.0) { error in
            if let error = error {
                XCTFail("waitForExpectations error: \(error)")
            }
        }
        
        // Assert
        XCTAssertTrue(mockPresenter.didCallDidFetchTodos)
        XCTAssertEqual(mockPresenter.todos.count, 2)
    }

    func testSearchTodosCallsPresenterWithFilteredTodos() {
        // Arrange
        let expectation = self.expectation(description: "Search todos")
        
        mockPresenter.onDidSearchTodos = { todos in
            expectation.fulfill()
        }
        
        // Act
        interactor.searchTodos(with: "Buy")
        
        waitForExpectations(timeout: 1.0) { error in
            if let error = error {
                XCTFail("waitForExpectations error: \(error)")
            }
        }
        
        // Assert
        XCTAssertTrue(mockPresenter.didCallSearchTodos)
        XCTAssertEqual(mockPresenter.todos.first?.title, "Buy milk")
        XCTAssertEqual(mockPresenter.todos.count, 1)
    }

    func testCreateTodoCallsDidCreateTodo() {
        // Arrange
        let expectation = self.expectation(description: "Create todo")
        
        mockPresenter.onDidCreateTodo = { todo in
            expectation.fulfill()
        }
        
        // Act
        interactor.createTodo()
        
        waitForExpectations(timeout: 1.0) { error in
            if let error = error {
                XCTFail("waitForExpectations error: \(error)")
            }
        }
        
        // Assert
        XCTAssertTrue(mockPresenter.didCallDidCreateTodo)
        XCTAssertEqual(mockPresenter.createdTodo?.title, "New todo")
    }
}

