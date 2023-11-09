//
//  NEOResponse.swift
//  NeoNeo4
//
//  Created by Steve Schwedt on 2/5/21.
//  Copyright © 2021 Steven Schwedt. All rights reserved.
//

import Foundation
import Combine

struct NEOResponse {
    let neos: [NEO]
    
    enum CodingKeys: String, CodingKey {
        case neos = "near_earth_objects"
    }
}

struct NEO: Decodable, Hashable  {
    let name: String
    let designation: String
    let isDangerous: Bool
    
    enum CodingKeys: String, CodingKey {
        case name, designation
        case isDangerous = "is_potentially_hazardous_asteroid"
    }
}

extension NEOResponse: ServiceResponseModel {
    static var defaultRequest: HTTPRequest? {
        HTTPRequest(
            service: Service.nasa,
            path: "/neo/rest/v1/neo/browse",
            additionalQueryItems: [
                URLQueryItem(name: "page", value: "1"),
                URLQueryItem(name: "size", value: "20")
        ])
    }
}
