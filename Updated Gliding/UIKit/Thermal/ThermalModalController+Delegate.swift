//
//  ThermalModalController+Delegate.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 3/6/24.
//

import UIKit

extension ThermalModalController {
    // WILL BE LOGIC FOR ACTIVE NAVIATION THERMAL
    func completion() {
        print("COMPLETED DISMISSAL")
    }
    // WILL BE LOGIC FOR ACTIVE NAVIATION THERMAL
    
    func handleNavigateTo() {
        self.dismiss(animated: true, completion: completion)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 0 else { return }
        if indexPath.row == 7 {
            handleNavigateTo()
        }
    }
}
