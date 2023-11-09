//
//  MockURLSession.swift
//  Copyright © 2021 Steven Schwedt. All rights reserved.
//

import Foundation
import Combine
@testable import NeoNeo5

class MockURLSession: DataTaskPublishing {
    func apiResponse(for request: HTTPRequest) -> AnyPublisher<APIResponse, URLError> {
        let responseFileName = MockURLSession.mockResponses[request.responseKey]
        
        let path = Bundle(for: MockURLSession.self).path(forResource: responseFileName, ofType: "json")
        let url = URL(fileURLWithPath: path ?? "")
        let jsonData = try? Data(contentsOf: url)
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)
        let data = APIResponse(data: jsonData!, response: response!)
        return Just(data).setFailureType(to: URLError.self).eraseToAnyPublisher()
    }
    
    static func mock(request: HTTPRequest?, jsonFileName: String) {
        guard let request = request else { return }
        
        mockResponses[request.responseKey] = jsonFileName
    }
    
    private static var mockResponses: [String: String] = [:]
}

extension HTTPRequest {
    
    var responseKey: String {
        service.rawValue + path
    }
}
