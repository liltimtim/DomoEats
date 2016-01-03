//
//  DomoEatsTests.swift
//  DomoEatsTests
//
//  Created by Timothy Barrett on 12/27/15.
//  Copyright © 2015 Timothy Barrett. All rights reserved.
//

import XCTest
@testable import DomoEats

class DomoEatsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}

class YelpAPI_Tests: XCTestCase {
    func testSearchAPI() {
        let exp = expectationWithDescription("get results from search")
        YelpAPI.shared.search(forLocation: "Augusta") { (places, error) -> Void in
            for place in places {
                XCTAssertNotNil(place.name)
                XCTAssertNotNil(place.yelpID)
            }
            exp.fulfill()
        }
        waitForExpectationsWithTimeout(10, handler: nil)
    }
}
