//
//  SampleTests.swift
//  SampleTests
//
//  Created by Adattiri, Ramya (Cognizant) on 27/12/18.
//  Copyright © 2018 Adattiri, Ramya (Cognizant). All rights reserved.
//

import XCTest

class SampleTests: XCTestCase {

    var vc: ViewController?
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        vc = ViewController()
    }

    override func tearDown() {
        super.tearDown()
        vc = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testCheckForDigitsCount() {
        for i in 0...6 {
            XCTAssertTrue(vc!.checkForDigitsCount("ABC12345", limit: i))
            print(i)
        }
    }
    
    func testApi() {
        let expectation = self.expectation(description: "Checking")
        
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
