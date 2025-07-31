//
//  MockURLProtocol.swift
//  EffectiveTodoAppTests
//
//  Created by Bulat Zaripov on 31.07.2025.
//

import Foundation

final class MockURLProtocol: URLProtocol {
    static var testData: Data?
    static var response: URLResponse?
    static var error: Error?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if let error = MockURLProtocol.error {
            client?.urlProtocol(self, didFailWithError: error)
        } else {
            if let response = MockURLProtocol.response {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            if let data = MockURLProtocol.testData {
                client?.urlProtocol(self, didLoad: data)
            }
            client?.urlProtocolDidFinishLoading(self)
        }
    }

    override func stopLoading() {
    }
}

