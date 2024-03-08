//
//  ThermalModalController.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/19/24.
//

import MapKit

class ThermalModalController: UITableViewController {
    let thermal: Thermal
    let thermalStore: ThermalStore
    let thermalModalDataSource: ThermalModalDataSource
    var thermalAnnotationView: ThermalAnnotationView? = nil
    var glidingMapViewController: GlidingMapViewController
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ thermal: Thermal, _ thermalStore: ThermalStore, _ glidingMapViewController: GlidingMapViewController, _ view: MKAnnotationView) {
        self.thermal = thermal
        self.thermalStore = thermalStore
        self.glidingMapViewController = glidingMapViewController
        self.thermalModalDataSource = ThermalModalDataSource(thermal: thermal)
        super.init(nibName: nil, bundle: nil)
        self.tableView = UITableView()
        self.tableView.dataSource = self.thermalModalDataSource
        setupTableView(thermal)
        self.setupModalView()
        
        guard let thermalAnnotationView = view as? ThermalAnnotationView else { return }
        self.thermalAnnotationView = thermalAnnotationView
    }
    
    func setupTableView(_ thermal: Thermal) {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func setupModalView() {
        self.modalPresentationStyle = .pageSheet
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            cell.textLabel!.text = "Occurance Info"
            cell.textLabel!.font = UIFont.boldSystemFont(ofSize: 30.0)
        case (0, 1):
            cell.textLabel!.text = String(format: "Glider Name: %@", thermal.glider != nil ? thermal.glider!.name : "No Name")
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
            cell.textLabel!.text = String(format: "Altitude: %f", thermal.location.altitude)
        case (0,7):
            cell.backgroundColor = .darkGray
            guard let textLabel = cell.textLabel else { return cell }
            textLabel.text = "Travel to this thermal"
            textLabel.textColor = .white
            textLabel.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        case (0,8):
            cell.textLabel!.text = ""
        case (0,9):
            cell.backgroundColor = .darkGray
            guard let textLabel = cell.textLabel else { return cell }
            textLabel.text = "Cancel"
            textLabel.textColor = .white
            textLabel.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
            
        default:
            cell.textLabel!.text = " "
        }
        return cell
    }
}
