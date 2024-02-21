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
    
    let altimeter: CMAltimeter
    let operationQueue: OperationQueue
    var navigationModel: NavigationModel?
    
    init() {
        self.altimeter = CMAltimeter()
        self.operationQueue = OperationQueue()
    }
    
    func startAbsoluteAltitudeRecording() throws {
        guard self.navigationModel != nil else { throw BarometricModelError.StartingRecordingWithoutNavigationModelError }
        if CMAltimeter.isAbsoluteAltitudeAvailable() {
            self.altimeter.startAbsoluteAltitudeUpdates(to: self.operationQueue, withHandler: handleAbsoluteAltitudeUpdate)
            
        }
    }
    
    func startRelativeAltitudeRecording() throws {
        guard self.navigationModel != nil else { throw BarometricModelError.StartingRecordingWithoutNavigationModelError }
        if CMAltimeter.isRelativeAltitudeAvailable() {
            self.altimeter.startRelativeAltitudeUpdates(to: self.operationQueue, withHandler: handleRelativeAltitudeUpdate)
            
        }
    }
    
    func handleAbsoluteAltitudeUpdate(_ absoluteAltitudeData: CMAbsoluteAltitudeData?, _ errorOpt: (any Error)?) {
        if let error = errorOpt { print(error.localizedDescription); return }
        
//        let newabsolutebarometricaltitude = absolutebarometricaltitude(
//            date: DateTime().toString(),
//            absoluteAltitude: absoluteAltitudeData?.altitude,
//            absoluteAccuracy: absoluteAltitudeData?.accuracy,
//            absolutePrecision: absoluteAltitudeData?.precision
//        )
//        self.absoluteBarometricAltitude = newAbsoluteBarometricAltitude
        
    }
    
    func handleRelativeAltitudeUpdate(_ relativeAltitudeData: CMAltitudeData?, _ errorOpt: (any Error)?) {
        if let error = errorOpt { print(error.localizedDescription); return }
        
//        let newRelativeBarometricAltitude = RelativeBarometricAltitude(
//            date: DateTime().toString(),
//            relativeAltitude: relativeAltitudeData?.relativeAltitude,
//            relativePressure: relativeAltitudeData?.pressure
//        )
//        self.relativeBarometricAltitude = newRelativeBarometricAltitude
    }
}
