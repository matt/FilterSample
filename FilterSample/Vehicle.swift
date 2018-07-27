//
//  Vehicle.swift
//  FilterSample
//
//  Created by Matthew Mohrman on 7/26/18.
//  Copyright © 2018 Matthew Mohrman. All rights reserved.
//

import Foundation

struct Vehicle {
    var isBatteryElectric: Bool
    var brand: String
    var model: String
    var initialProductionYear: Int
    
    var name: String {
        return "\(brand) \(model)"
    }
}

extension Vehicle: Equatable {
    static func == (lhs: Vehicle, rhs: Vehicle) -> Bool {
        return lhs.isBatteryElectric == rhs.isBatteryElectric &&
            lhs.brand == rhs.brand &&
            lhs.model == rhs.model &&
            lhs.initialProductionYear == rhs.initialProductionYear
    }
}
