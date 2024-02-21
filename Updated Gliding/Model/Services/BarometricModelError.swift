//
//  BarometricModelError.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/19/24.
//

import Foundation

enum BarometricModelError: Error {
    case StartingRecordingWithoutNavigationModelError
    case HandlingAltitudeUpdateWithoutNavigationModelError
}
