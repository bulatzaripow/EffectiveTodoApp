//
//  TodoListPresenterTests.swift
//  EffectiveTodoAppTests
//
//  Created by Bulat Zaripov on 29.07.2025.
//

import XCTest
@testable import EffectiveTodoApp

final class TodoListPresenterTests: XCTestCase {
    
    private var presenter: TodoListPresenter!
    private var mockView: MockTodoListView!
    private var mockInteractor: MockTodoListInteractor!
    private var mockRouter: MockTodoListRouter!
    
    override func setUp() {
        super.setUp()
        
        // Arrange
        mockView = MockTodoListView()
        mockInteractor = MockTodoListInteractor()
        mockRouter = MockTodoListRouter()
        
        let todosAPIUrl = URL(string: "https://dummyjson.com/todos")!
        let todoNetworkService = TodoNetworkService(url: todosAPIUrl)
        
        presenter = TodoListPresenter(networkService: todoNetworkService)
        presenter.view = mockView
        presenter.interactor = mockInteractor
        presenter.router = mockRouter
    }
    
    func test_viewDidLoad_callsFetchTodos() {
        // Act
        presenter.viewDidLoad()
        
        // Assert
        XCTAssertTrue(mockInteractor.didCallFetchTodos)
    }

    func test_didTapAddButton_callsCreateTodo() {
        // Act
        presenter.didTapAddButton()
        
        // Assert
        XCTAssertTrue(mockInteractor.didCallCreateTodo)
    }

    func test_didFetchTodos_displaysInView() {
        // Arrange
        let todos = [
            Todo(id: 1, title: "Test")
        ]
        
        // Act
        presenter.didFetchTodos(todos)
        
        // Assert
        XCTAssertEqual(mockView.receivedTodos.count, 1)
        XCTAssertEqual(mockView.receivedTodos[0].id, 1)
        XCTAssertEqual(mockView.receivedTodos[0].title, "Test")
    }
}
