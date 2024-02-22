//
//  BarometricModel.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/19/24.
//

import CoreMotion

class BarometricModel: ObservableObject {
    @Published var absoluteBarometricAltitude: AbsoluteBarometricAltitude?
    @Published var relativeBarometricAltitude: RelativeBarometricAltitude?
    var flightStore: FlightStore?
    
    let altimeter: CMAltimeter
    let operationQueue: OperationQueue
    
    init() {
        self.altimeter = CMAltimeter()
        self.operationQueue = OperationQueue()
    }
    
    func startAbsoluteAltitudeRecording() throws {
        if CMAltimeter.isAbsoluteAltitudeAvailable() {
            self.altimeter.startAbsoluteAltitudeUpdates(to: self.operationQueue, withHandler: handleAbsoluteAltitudeUpdate)
        } else {
            throw BarometricModelError.AbsoluteAltitudeNotAvailableError
        }
    }
    
    func startRelativeAltitudeRecording() throws {
        if CMAltimeter.isRelativeAltitudeAvailable() {
            self.altimeter.startRelativeAltitudeUpdates(to: self.operationQueue, withHandler: handleRelativeAltitudeUpdate)
        } else {
            throw BarometricModelError.RelativeAltitudeNotAvailableError
        }
    }
    
    func handleAbsoluteAltitudeUpdate(_ absoluteAltitudeData: CMAbsoluteAltitudeData?, _ errorOpt: (any Error)?) {
        if let error = errorOpt { print(error.localizedDescription); return }
        
        let newAbsoluteBarometricAltitude = AbsoluteBarometricAltitude(
            date: DateTime().toString(),
            absoluteAltitude: absoluteAltitudeData?.altitude,
            absoluteAccuracy: absoluteAltitudeData?.accuracy,
            absolutePrecision: absoluteAltitudeData?.precision
        )
        self.absoluteBarometricAltitude = newAbsoluteBarometricAltitude
        
        guard let flight = self.flightStore?.flight else { return }
        do {
            try flight.addNewAbsoluteBarometricAltitudeToFlight(newAbsoluteBarometricAltitude: newAbsoluteBarometricAltitude)
            print("ADDING ABSOLUTE")
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func handleRelativeAltitudeUpdate(_ relativeAltitudeData: CMAltitudeData?, _ errorOpt: (any Error)?) {
        if let error = errorOpt { print(error.localizedDescription); return }
        
        let newRelativeBarometricAltitude = RelativeBarometricAltitude(
            date: DateTime().toString(),
            relativeAltitude: relativeAltitudeData?.relativeAltitude as? Double,
            relativePressure: relativeAltitudeData?.pressure as? Double
        )
        self.relativeBarometricAltitude = newRelativeBarometricAltitude
        
        guard let flight = self.flightStore?.flight else { return }
        do {
            try flight.addNewRelativeBarometricAltitudeToFlight(newRelativeBarometricAltitude: newRelativeBarometricAltitude)
            print("ADDING Relative")
        } catch {
            print(error.localizedDescription)
        }
    }
}
