//
//  VehicleViewController.swift
//  FilterSample
//
//  Created by Matthew Mohrman on 7/26/18.
//  Copyright © 2018 Matthew Mohrman. All rights reserved.
//

import UIKit

class VehicleViewController: UIViewController {
    @IBOutlet weak var initialProductionYearLabel: UILabel!
    
    var vehicle: Vehicle!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = vehicle.name
        initialProductionYearLabel.text = "The first production year for the \(vehicle.name) was \(vehicle.initialProductionYear)."
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
