//
//  TopPostFlightMetricsView.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/21/24.
//

import SwiftUI

struct TopPostFlightMetricsView: View {
    @EnvironmentObject var flightStore: FlightStore
    
    var body: some View {
        VStack {
            if let flight = flightStore.flight {
                Text("Glider Name: \(flight.glider.name)")
                Text("Date of Flight: \(flight.dateOfFlight)")
                Text("Distance Traveled: \(flight.distanceTraveled)")
                Text("GPS Altitude Gained: \(flight.gpsHeightGained)")
                Text("Absolute Altitude Gained: \(flight.absoluteBarometricHeightGained)")
                Text("Relative Altitude Gained: \(flight.relativeBarometricHeightGained)")
            }
        }
        .padding(.vertical, 50.0)
    }
}

#Preview {
    TopPostFlightMetricsView()
}
