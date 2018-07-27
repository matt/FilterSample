//
//  VehicleTests.swift
//  FilterSampleTests
//
//  Created by Matthew Mohrman on 7/26/18.
//  Copyright © 2018 Matthew Mohrman. All rights reserved.
//

import XCTest
@testable import FilterSample

class VehicleTests: XCTestCase {
    let isBatteryElectric = true
    let brand = "Nissan"
    let model = "Leaf"
    let initialProductionYear = 2010
    var vehicle: Vehicle!
    
    override func setUp() {
        super.setUp()
        vehicle = Vehicle(isBatteryElectric: isBatteryElectric, brand: brand, model: model, initialProductionYear: initialProductionYear)
    }
    
    override func tearDown() {
        vehicle = nil
        super.tearDown()
    }
    
    func testIsBatteryElectric() {
        XCTAssertEqual(vehicle.isBatteryElectric, isBatteryElectric)
    }
    
    func testBrand() {
        XCTAssertEqual(vehicle.brand, brand)
    }
    
    func testModel() {
        XCTAssertEqual(vehicle.model, model)
    }
    
    func testInitialProductionYear() {
        XCTAssertEqual(vehicle.initialProductionYear, initialProductionYear)
    }
    
    func testName() {
        XCTAssertEqual(vehicle.name, "\(brand) \(model)")
    }
    
}
