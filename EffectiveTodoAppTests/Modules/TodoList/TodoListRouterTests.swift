//
//  TodoListRouterTests.swift
//  EffectiveTodoAppTests
//
//  Created by Bulat Zaripov on 29.07.2025.
//

import XCTest
@testable import EffectiveTodoApp

final class TodoListRouterTests: XCTestCase {
    func test_openTodoDetail_pushesDetailVC() {
        // Arrange
        let mockNavController = MockNavigationController()
        let mockViewController = MockViewController()

        mockNavController.viewControllers = [mockViewController]

        let router = TodoListRouter()
        router.view = mockViewController

        let window = UIWindow()
        window.rootViewController = mockNavController
        window.makeKeyAndVisible()

        // Act
        router.openTodoDetail(
            from: MockTodoListView(),
            todo: Todo(id: 1, title: "Test", completed: false)
        )

        // Assert
        XCTAssertTrue(mockNavController.didPushViewController)
        XCTAssertTrue(mockNavController.pushedViewController is TodoDetailViewController)
    }
}
