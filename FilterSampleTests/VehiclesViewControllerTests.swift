//
//  VehiclesViewControllerTests.swift
//  FilterSampleTests
//
//  Created by Matthew Mohrman on 7/26/18.
//  Copyright © 2018 Matthew Mohrman. All rights reserved.
//

import XCTest
@testable import FilterSample

class VehiclesViewControllerTests: XCTestCase {
    let bolt = Vehicle(isBatteryElectric: true, brand: "Chevrolet", model: "Bolt", initialProductionYear: 2016)
    let impala = Vehicle(isBatteryElectric: false, brand: "Chevrolet", model: "Impala", initialProductionYear: 1957)
    let cruze = Vehicle(isBatteryElectric: false, brand: "Chevrolet", model: "Cruze", initialProductionYear: 2008)
    let malibu = Vehicle(isBatteryElectric: false, brand: "Chevrolet", model: "Malibu", initialProductionYear: 1963)
    var viewController: VehiclesViewController!
    
    override func setUp() {
        super.setUp()
        viewController = VehiclesViewController()
        viewController.vehicles = [bolt, cruze, impala, malibu]
    }
    
    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
    
    func testFilterAllVehicles() {
        viewController.filterVehicles(isBatteryElectricIncluded: true, searchText: nil)
        
        XCTAssertEqual(viewController.filteredVehicles.count, 4)
        XCTAssertEqual(viewController.filteredVehicles[0], bolt)
        XCTAssertEqual(viewController.filteredVehicles[1], cruze)
        XCTAssertEqual(viewController.filteredVehicles[2], impala)
        XCTAssertEqual(viewController.filteredVehicles[3], malibu)
    }
    
    func testFilterInternalCombusionEngineVehicles() {
        viewController.filterVehicles(isBatteryElectricIncluded: false, searchText: nil)
        
        XCTAssertEqual(viewController.filteredVehicles.count, 3)
        XCTAssertEqual(viewController.filteredVehicles[0], cruze)
        XCTAssertEqual(viewController.filteredVehicles[1], impala)
        XCTAssertEqual(viewController.filteredVehicles[2], malibu)
    }
    
    func testFilterAllVehiclesWithSearchString() {
        viewController.filterVehicles(isBatteryElectricIncluded: true, searchText: "z")
        
        XCTAssertEqual(viewController.filteredVehicles.count, 1)
        XCTAssertEqual(viewController.filteredVehicles[0], cruze)
    }
    
    func testFilterInternalCombusionEngineVehiclesWithSearchString() {
        viewController.filterVehicles(isBatteryElectricIncluded: false, searchText: "bo")
        
        XCTAssertEqual(viewController.filteredVehicles.count, 0)
    }
}
