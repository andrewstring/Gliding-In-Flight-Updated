//
//  ThermalModalController.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/19/24.
//

import UIKit

class ThermalModalController: UIViewController {
    let tableView: UITableView
    let tableViewDataSource: ThermalModalDataSource
    let thermal: Thermal
    let thermalModalDataSource: ThermalModalDataSource
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ thermal: Thermal) {
        self.thermal = thermal
        self.tableView = UITableView()
        self.thermalModalDataSource = ThermalModalDataSource(thermal: thermal)
        setupTableView(thermal)
        self.setupModalView()
    }
    
    func setupTableView(_ thermal: Thermal) {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func setupModalView() {
        self.modalPresentationStyle = .popover
        self.modalTransitionStyle = .crossDissolve
    }
    
}

class ThermalModalDataSource: NSObject, UITableViewDataSource {
    let thermal: Thermal
    
    init(thermal: Thermal) {
        self.thermal = thermal
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section != 0 { return 0 }
        if section == 0 && self.thermal.location.altitude != nil { return 7 }
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            cell.textLabel!.text = "Occurance Info"
            cell.textLabel!.font = UIFont.boldSystemFont(ofSize: 30.0)
        case (0, 1):
            cell.textLabel!.text = String(format: "Glider Name: %@", thermal.glider.name)
        case (0,2):
            cell.textLabel!.text = String(format: "Recorded On: %@", thermal.detectedOn)
        case (0,3):
            cell.textLabel!.text = "Location Info"
            cell.textLabel!.font = UIFont.boldSystemFont(ofSize: 30.0)
        case (0, 4):
            cell.textLabel!.text = String(format: "Latitude: %f", thermal.location.latitude)
        case (0,5):
            cell.textLabel!.text = String(format: "Longitude: %f", thermal.location.longitude)
        case (0,6):
            cell.textLabel!.text = String(format: "Altitude: %f", thermal.location.altitude!)
        default:
            cell.textLabel!.text = " "
        }
        return cell
    }
    
}
