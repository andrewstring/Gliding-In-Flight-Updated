//
//  GlidingMapViewControllerError.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/20/24.
//

import Foundation

enum GlidingMapViewControllerError: Error {
    case HandlingMapStateUpdateWithoutLocationError
    case HandlingPostFlightMapStateUpdateWithoutFlightError
}
