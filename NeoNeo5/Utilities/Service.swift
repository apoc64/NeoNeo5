//
//  Service.swift
//  NeoNeo4
//
//  Created by Steve Schwedt on 2/3/21.
//  Copyright © 2021 Steven Schwedt. All rights reserved.
//

import Foundation

enum Service: String, ServiceProviding {
    case nasa
    
    var baseURLString: String {
        switch self {
        case .nasa:
            return "api.nasa.gov"
        }
    }
    
    var isHttps: Bool {
        switch self {
        default:
            return true
        }
    }
    
    var defaultQueryItems: [URLQueryItem]? {
        switch self {
        case .nasa:
            let apiKey = "DEMO_KEY" // Get from gitignored config

            return [URLQueryItem(name: "api_key", value: apiKey)]
        }
    }
}
