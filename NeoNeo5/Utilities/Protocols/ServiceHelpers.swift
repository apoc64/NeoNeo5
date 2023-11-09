//
//  ServiceHelpers.swift
//  Copyright © 2021 Steven Schwedt. All rights reserved.
//

import Foundation

protocol ServiceProviding {
    var rawValue: String { get }
    var baseURLString: String { get }
    var isHttps: Bool { get }
    var defaultQueryItems: [URLQueryItem]? { get }
}

extension ServiceProviding {
    var defaultQueryItems: [URLQueryItem]? { nil }
}
