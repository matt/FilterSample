//
//  FilterUITests.swift
//  FilterSampleUITests
//
//  Created by Matthew Mohrman on 7/26/18.
//  Copyright © 2018 Matthew Mohrman. All rights reserved.
//

import XCTest

class FilterUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        app = XCUIApplication()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDisplayFilterView() {
        app.launch()
        
        XCTAssertFalse(app.isDisplayingFilterView)
        XCTAssertFalse(app.isDisplayingSemiTransparentView)
        
        app.buttons["Filter"].tap()
        
        XCTAssertTrue(app.isDisplayingFilterView)
        XCTAssertTrue(app.isDisplayingSemiTransparentView)
    }
    
    func testHideFilterViewWithBarButtonItem() {
        app.launch()
        app.buttons["Filter"].tap()
        
        XCTAssertTrue(app.isDisplayingFilterView)
        XCTAssertTrue(app.isDisplayingSemiTransparentView)
        
        app.buttons.matching(identifier: "Done").element(boundBy: 0).tap()
        
        XCTAssertFalse(app.isDisplayingFilterView)
        XCTAssertFalse(app.isDisplayingSemiTransparentView)
    }
    
    func testHideFilterViewWithKeyboardSearchButton() {
        app.launch()
        app.buttons["Filter"].tap()
        
        XCTAssertTrue(app.isDisplayingFilterView)
        XCTAssertTrue(app.isDisplayingSemiTransparentView)
        
        app.buttons.matching(identifier: "Done").element(boundBy: 1).tap()
        
        XCTAssertFalse(app.isDisplayingFilterView)
        XCTAssertFalse(app.isDisplayingSemiTransparentView)
    }
}

extension XCUIApplication {
    var isDisplayingFilterView: Bool {
        return otherElements["filterView"].isHittable
    }
    
    var isDisplayingSemiTransparentView: Bool {
        return otherElements["semiTransparentView"].exists && otherElements["semiTransparentView"].isHittable
    }
}
