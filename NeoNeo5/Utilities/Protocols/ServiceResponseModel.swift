//
//  ServiceModel.swift
//  Copyright © 2021 Steven Schwedt. All rights reserved.
//

import Foundation
import Combine

protocol ServiceResponseModel: Decodable {
    static func performRequest(request: HTTPRequest) -> AnyPublisher<Self, Error>
    static var defaultRequest: HTTPRequest? { get }
    static func performRequest() -> AnyPublisher<Self, Error>
}

extension ServiceResponseModel {
    
    static func performRequest() ->AnyPublisher<Self, Error> {
        guard let request = defaultRequest else {
            return Fail(error: HTTPRequestError("Missing default request") ).eraseToAnyPublisher()
        }
        
        return performRequest(request: request)
    }
    
    static func performRequest(request: HTTPRequest) -> AnyPublisher<Self, Error> {
        return NetworkingManager.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: Self.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static var defaultRequest: HTTPRequest? { nil }
}

struct HTTPRequestError: Error {
    var localizedDescription: String { return errorDescription }
    
    private let errorDescription: String
    
    init(_ description: String = "Invalid HTTP request") {
        self.errorDescription = description
    }
}
