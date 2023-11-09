//
//  HTTPHelpers.swift
//  Copyright © 2021 Steven Schwedt. All rights reserved.
//

import Foundation

/** An interface for generating URLRequests with Helper Services */
struct HTTPRequest {
    let service: ServiceProviding
    let path: String
    let additionalQueryItems: [URLQueryItem]?
    // let method: HTTPMethod
    // auth, headers...?
    
    var url: URL? {
        return components.url
    }
    
    private var components: URLComponents {
        var components = URLComponents()
        components.scheme = service.isHttps ? "https" : "http"
        components.host = service.baseURLString
        components.path = path
        components.queryItems = allQueryItems
        
        return components
    }
    
    private var allQueryItems: [URLQueryItem]? {
        var items = additionalQueryItems ?? []
        items.append(contentsOf: service.defaultQueryItems ?? [])
        
        return items.isEmpty ? nil : items
    }
}
