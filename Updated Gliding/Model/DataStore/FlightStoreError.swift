//
//  FlightStoreError.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/18/24.
//

import Foundation

enum FlightStoreError: Error {
    case flightURLRetrievalError
    case flightSaveError
    case flightRemoveError
    
    case parsingFlightDataError
}
