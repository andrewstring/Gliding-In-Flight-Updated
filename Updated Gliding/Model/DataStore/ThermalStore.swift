//
//  ThermalStore.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/28/24.
//

import Foundation

class ThermalStore: ObservableObject {
    @Published var thermals: [Thermal]
    var thermalAnnotationViews: [ThermalAnnotationView]
    var activeThermalAnnotationView: ThermalAnnotationView?
    
    init() {
        self.thermals = []
        self.thermalAnnotationViews = []
    }
    
    func setActiveThermalAnnotationView(id: String) {
        self.activeThermalAnnotationView?.deactivateIcon()
        let filteredThermalAnnotationViews = thermalAnnotationViews.filter {$0.id == id}
        if filteredThermalAnnotationViews.count > 0 {
            self.activeThermalAnnotationView = filteredThermalAnnotationViews[0]
        }
        self.activeThermalAnnotationView?.activateIcon()
    }
    
    func unsetActiveThermalAnnotationView() {
        self.activeThermalAnnotationView?.deactivateIcon()
        self.activeThermalAnnotationView = nil
    }
}
