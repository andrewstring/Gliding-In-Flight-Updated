//
//  DateTime.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/19/24.
//

import Foundation

struct DateTime {
    typealias Unit = Int
    
    let timeZone: Unit
    let month: Unit
    let day: Unit
    let year: Unit
    let hour: Unit
    let minute: Unit
    let second: Unit
    
    init() {
        let date = Date()
        let calendar = Calendar.current
        self.timeZone = calendar.component(.timeZone, from: date)
        self.month = calendar.component(.month, from: date)
        self.day = calendar.component(.day, from: date)
        self.year = calendar.component(.year, from: date)
        self.hour = calendar.component(.hour, from: date)
        self.minute = calendar.component(.minute, from: date)
        self.second = calendar.component(.second, from: date)
    }
    
    func toString() -> String {
        return "\(self.timeZone) \(self.month)\(self.day)\(self.year)\(self.hour)"
        + "\(self.minute)\(self.second)"
    }
}
