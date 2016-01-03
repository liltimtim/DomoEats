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
class DEYelpImageCache_Tests: XCTestCase {
    func testLoadAndRetrieveImageFromCache() {
        DEYelpImageCache.shared.addImage(UIImage(), key: "test_image")
        XCTAssertNotNil(DEYelpImageCache.shared.getImage("test_image"))
    }
}

class YelpAPI_Tests: XCTestCase {
    func testSearchAPI() {
        let exp = expectationWithDescription("get results from search")
        YelpAPI.shared.search(forLocation: "Augusta") { (places, error) -> Void in
            for place in places {
                XCTAssertNotNil(place.name)
                XCTAssertNotNil(place.yelpID)
                XCTAssertNotNil(place.latitude)
                XCTAssertNotNil(place.long)
                XCTAssertNotNil(place.starRatingURL)
                print(place.imageURL)
                print(place.name)
                print(place.latitude)
                print(place.long)
                print(place.getFriendlyCategories())
            }
            exp.fulfill()
        }
        waitForExpectationsWithTimeout(10, handler: nil)
    }
    
    func testSearchWithFiltersNoFilters() {
        let exp = expectationWithDescription("Search without filters")
        YelpAPI.shared.search(forLocation: "Augusta", withCategoryFilters: []) { (places, error) -> Void in
            for place in places {
                XCTAssertNotNil(place.name)
                XCTAssertNotNil(place.yelpID)
                XCTAssertNotNil(place.latitude)
                XCTAssertNotNil(place.long)
                XCTAssertNotNil(place.starRatingURL)
                print(place.imageURL)
                print(place.name)
                print(place.latitude)
                print(place.long)
                print(place.getFriendlyCategories())
            }
            XCTAssertGreaterThan(places.count, 0)
            exp.fulfill()
        }
        waitForExpectationsWithTimeout(10, handler: nil)
    }
    
    func testSearchWithFiltersSingleFilter() {
        let exp = expectationWithDescription("Search without filters")
        YelpAPI.shared.search(forLocation: "Augusta", withCategoryFilters: ["bbq"]) { (places, error) -> Void in
            for place in places {
                XCTAssertNotNil(place.name)
                XCTAssertNotNil(place.yelpID)
                XCTAssertNotNil(place.latitude)
                XCTAssertNotNil(place.long)
                XCTAssertNotNil(place.starRatingURL)
                print(place.imageURL)
                print(place.name)
                print(place.latitude)
                print(place.long)
                print(place.getFriendlyCategories())
            }
            XCTAssertGreaterThan(places.count, 0)
            exp.fulfill()
        }
        waitForExpectationsWithTimeout(10, handler: nil)
    }
}
