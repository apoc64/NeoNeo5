//
//  NeoResponseTests.swift
//  NeoNeo4Tests
//
//  Created by Steve Schwedt on 2/5/21.
//  Copyright © 2021 Steven Schwedt. All rights reserved.
//

import XCTest
@testable import NeoNeo5

class NeoViewModelTests: XCTestCase {
    
    override class func setUp() {
        Container.register(DataTaskPublishing.self) { _ in MockURLSession() }
        MockURLSession.mock(request: NEOResponse.defaultRequest, jsonFileName: "neoResponse")
    }
    
    func testSuccessfulResponse() {
        let exp = expectation(description: "wait")
        
        let neoListVM = NEOListViewModel()
        neoListVM.fetchNEOS()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            let neos = neoListVM.neos
            XCTAssertEqual(neos.count, 2)
            XCTAssertEqual(neos.first?.displayString, "887 Alinda (A918 AA) DANGER")
            XCTAssertEqual(neos.last?.displayString, "1036 Ganymed (A924 UB)")
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 0.2)
    }
}
