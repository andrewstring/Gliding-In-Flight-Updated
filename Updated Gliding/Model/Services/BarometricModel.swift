//
//  BarometricModel.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/19/24.
//

import CoreMotion

class BarometricModel {
    let altimeter: CMAltimeter
    let operationQueue: OperationQueue
    var navigationModel: NavigationModel?
    
    init() {
        self.altimeter = CMAltimeter()
        self.operationQueue = OperationQueue()
    }
    
    func startAbsoluteAltitudeRecording() throws {
        guard let navigationModel = self.navigationModel else { throw BarometricModelError.StartingRecordingWithoutNavigationModelError }
        if CMAltimeter.isAbsoluteAltitudeAvailable() {
            self.altimeter.startAbsoluteAltitudeUpdates(to: self.operationQueue, withHandler: <#T##CMAbsoluteAltitudeHandler##CMAbsoluteAltitudeHandler##(CMAbsoluteAltitudeData?, Error?) -> Void#>)
            
        }
    }
    
    func startRelativeAltitudeRecording() throws {
        guard let navigationModel = self.navigationModel else { throw BarometricModelError.StartingRecordingWithoutNavigationModelError }
        if CMAltimeter.isRelativeAltitudeAvailable() {
            self.altimeter.startRelativeAltitudeUpdates(to: self.operationQueue, withHandler: <#T##CMAltitudeHandler##CMAltitudeHandler##(CMAltitudeData?, Error?) -> Void#>)
            
        }
    }
    
    func handleAbsoluteAltitudeUpdate(_ altitudeData: CMAbsoluteAltitudeData?, _ errorOpt: (any Error)?) {
        if let error = errorOpt { print(error.localizedDescription); return }
        guard let navigationModel = self.navigationModel else { throw }
        
    }
    
    func handleRelativeAltitudeUpdate(_ altitudeData: CMAltitudeData?, _ errorOpt: (any Error)?) {
        if let error = errorOpt { print(error.localizedDescription); return }
        guard let navigationModel = self.navigationModel else { throw  }
        
    }
    
    
}
