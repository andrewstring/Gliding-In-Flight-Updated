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
                if let minLatitude = flight.minLatitude {
                    Text("Min Latitude: \(minLatitude)")
                }
                if let maxLatitude = flight.maxLatitude {
                    Text("Max Latitude: \(maxLatitude)")
                }
                if let minLongitude = flight.minLongitude {
                    Text("Min Longitude: \(minLongitude)")
                }
                if let maxLongitude = flight.maxLongitude {
                    Text("Max Longitude: \(maxLongitude)")
                }
            }
        }
        .padding(.vertical, 50.0)
    }
}

#Preview {
    TopPostFlightMetricsView()
}
