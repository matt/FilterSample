//
//  VehiclesViewController.swift
//  FilterSample
//
//  Created by Matthew Mohrman on 7/26/18.
//  Copyright © 2018 Matthew Mohrman. All rights reserved.
//

import UIKit

class VehiclesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var batteryElectricVehiclesSwitch: UISwitch!
    @IBOutlet weak var filterViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var filterStackView: UIStackView!
    @IBOutlet weak var semiTransparentView: UIView!
    @IBOutlet weak var filterBarButtonItem: UIBarButtonItem!
    
    enum FilterBarButtonState: String {
        case filter = "Filter"
        case done = "Done"
    }
    
    var vehicles = [
        Vehicle(isBatteryElectric: true, brand: "Nissan", model: "Leaf", initialProductionYear: 2010),
        Vehicle(isBatteryElectric: true, brand: "BMW", model: "i3", initialProductionYear: 2013),
        Vehicle(isBatteryElectric: true, brand: "Tesla", model: "Model S", initialProductionYear: 2012),
        Vehicle(isBatteryElectric: true, brand: "Tesla", model: "Model X", initialProductionYear: 2015),
        Vehicle(isBatteryElectric: true, brand: "Tesla", model: "Model 3", initialProductionYear: 2017),
        Vehicle(isBatteryElectric: true, brand: "Chevrolet", model: "Bolt", initialProductionYear: 2016),
        Vehicle(isBatteryElectric: false, brand: "Ford", model: "Mustang", initialProductionYear: 1964),
        Vehicle(isBatteryElectric: false, brand: "Chevrolet", model: "Impala", initialProductionYear: 1957),
        Vehicle(isBatteryElectric: false, brand: "Chevrolet", model: "Cruze", initialProductionYear: 2008)
    ]
    
    var filteredVehicles: [Vehicle] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide filter view initially
        filterViewTopConstraint.constant = -filterStackView.bounds.size.height
        // sort up front to negate the need to constantly sort
        vehicles.sort { $0.name < $1.name }
        filterVehicles(isBatteryElectricIncluded: batteryElectricVehiclesSwitch.isOn, searchText: searchBar.text)
        
        filterStackView.accessibilityIdentifier = "filterView"
        semiTransparentView.accessibilityIdentifier = "semiTransparentView"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: animated)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        if let vehicleViewController = segue.destination as? VehicleViewController {
            vehicleViewController.vehicle = vehicles[indexPath.row]
        }
    }
    
    @IBAction func toggleFiltering(_ sender: UIBarButtonItem) {
        toggleFiltering(isDone: sender.title == FilterBarButtonState.done.rawValue)
    }
    
    @IBAction func toggleBatteryElectricVehicleVisibility(_ sender: UISwitch) {
        filterVehicles(isBatteryElectricIncluded: sender.isOn, searchText: searchBar.text)
        tableView.reloadData()
    }
    
    func filterVehicles(isBatteryElectricIncluded: Bool, searchText: String?) {
        filteredVehicles = isBatteryElectricIncluded ? vehicles : vehicles.filter { !$0.isBatteryElectric }
        
        if let searchText = searchText, searchText.count > 0 {
            // case-insensitive search
            filteredVehicles = filteredVehicles.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    private func toggleFiltering(isDone: Bool) {
        filterBarButtonItem.title = isDone ? FilterBarButtonState.filter.rawValue : FilterBarButtonState.done.rawValue
        filterViewTopConstraint.constant = isDone ? -filterStackView.bounds.size.height : 0
        semiTransparentView.isHidden = isDone
        
        if isDone {
            searchBar.resignFirstResponder()
        } else {
            searchBar.becomeFirstResponder()
        }
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
}

extension VehiclesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredVehicles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "vehicleCell", for: indexPath)
        
        let vehicle = filteredVehicles[indexPath.row]
        cell.textLabel?.text = vehicle.name
        
        return cell
    }
}

extension VehiclesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterVehicles(isBatteryElectricIncluded: batteryElectricVehiclesSwitch.isOn, searchText: searchText)
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        toggleFiltering(isDone: true)
    }
}
