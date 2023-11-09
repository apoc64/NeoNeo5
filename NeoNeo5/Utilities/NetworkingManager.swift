//
//  NetworkingManager.swift
//  Copyright © 2021 Steven Schwedt. All rights reserved.
//

import Foundation
import Combine

typealias APIResponse = URLSession.DataTaskPublisher.Output

protocol DataTaskPublishing {
    func apiResponse(for request: HTTPRequest) -> AnyPublisher<APIResponse, URLError>
}

extension URLSession: DataTaskPublishing {
    func apiResponse(for request: HTTPRequest) -> AnyPublisher<APIResponse, URLError> {
        guard let url = request.url else { return Fail(error: URLError(.badURL, userInfo: [:] ) ).eraseToAnyPublisher() }
        
        return dataTaskPublisher(for: url).eraseToAnyPublisher()
    }
}

/** Handles networking for helper apps with injectable dataTaskPublisher defaulted to URLSession*/
class NetworkingManager {
    static func dataTaskPublisher(for request: HTTPRequest) -> AnyPublisher<APIResponse, URLError> {
        return publisher.apiResponse(for: request)
    }
    
    private static var publisher: DataTaskPublishing {
        Container.resolve(DataTaskPublishing.self) ?? URLSession.shared
    }
}

