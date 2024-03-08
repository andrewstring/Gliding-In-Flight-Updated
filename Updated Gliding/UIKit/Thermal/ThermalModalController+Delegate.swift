//
//  ThermalModalController+Delegate.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 3/6/24.
//

import UIKit

extension ThermalModalController {
    
    func handleNavigateTo() {
        guard let thermalAnnotationView = self.thermalAnnotationView else { return }
        self.navigateToHandler(thermalAnnotationView)
        self.dismiss(animated: true)
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
