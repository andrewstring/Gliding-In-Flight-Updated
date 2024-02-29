//
//  ThermalStore.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/28/24.
//

import Foundation

class ThermalStore: ObservableObject {
    @Published var thermals: [Thermal]
    
    init() {
        self.thermals = []
    }
}
