//
//  MVVMTestProjectTests.swift
//  MVVMTestProjectTests
//
//  Created by Martin Pinka on 12.09.16.
//  Copyright © 2016 The Funtasty. All rights reserved.
//

import XCTest

class Test1SeasonServices: SeasonsServices {
    
    func getSeasons() -> [Season] {
        
        return [Season(name: "blah", episodes: [])]
    }
}

class MVVMTestProjectTests: XCTestCase {
    
    let services = Test1SeasonServices()
    
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
    
    func testLoadData() {
        
        
        let vm = SeasonsTableViewModel(seasonsServices: services)
        vm.load()
        
        XCTAssert(vm.seasons.count == 1 && vm.seasons[0].title == "blah", "doesnt have 1 season")
        
    }
    
}
