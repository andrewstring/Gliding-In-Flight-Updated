//
//  ThermalModalController+Delegate.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 3/6/24.
//

import UIKit

extension ThermalModalController {
    // WILL BE LOGIC FOR ACTIVE NAVIATION THERMAL
    func generateHandler(_ thermalAnnotationView: ThermalAnnotationView) -> (() -> Void) {
        return { [weak self] in
            guard let mapView = self?.glidingMapViewController.mapView else { return }
            guard let coordinate = self?.thermalStore.activeThermalAnnotationView?.annotation?.coordinate else { return }
            mapView.setCenter(coordinate, animated: true)
        }
        
    }
    // WILL BE LOGIC FOR ACTIVE NAVIATION THERMAL
    
    func handleNavigateTo() {
        guard let thermalAnnotationView = self.thermalAnnotationView else { return }
        self.dismiss(animated: true, completion: generateHandler(thermalAnnotationView))
        
        if let activeThermalAnnotationView = thermalStore.activeThermalAnnotationView {
            activeThermalAnnotationView.deactivateIcon()
        }
        thermalStore.activeThermalAnnotationView = thermalAnnotationView
        thermalAnnotationView.activateIcon()
    }
    
    func handleCancel() {
        self.dismiss(animated: true)
        
        guard let thermalAnnotationView = self.thermalAnnotationView else { return }
        thermalAnnotationView.deactivateIcon()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 0 else { return }
        switch indexPath.row {
        case 7:
            handleNavigateTo()
        case 9:
            handleCancel()
        default:
            return
        }
    }
}
