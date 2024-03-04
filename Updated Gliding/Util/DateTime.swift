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
    
    func toStringFull() -> String {
        return "\(self.timeZone) \(self.month)\(self.day)\(self.year)\(self.hour)"
        + "\(self.minute)\(self.second)"
    }
    
    func toString() -> String {
        let monthStr = self.month < 10 ? "0\(self.month)" : "\(self.month)"
        let dayStr = self.day < 10 ? "0\(self.day)" : "\(self.day)"
        let yearStr = "\(self.year)"
        let hourStr = self.hour < 10 ? "0\(self.hour)" : "\(self.hour)"
        let minuteStr = self.minute < 10 ? "0\(self.minute)" : "\(self.minute)"
        let secondStr = self.second < 10 ? "0\(self.second)" : "\(self.second)"
        return "\(monthStr)/\(dayStr)/\(yearStr)-\(hourStr):\(minuteStr):\(secondStr)"
    }
    
    static func secondsDifference(_ first: String, _ second: String) -> Int {
        let monthOne: Int = Int(String(first.prefix(2)))!
        let monthTwo: Int = Int(String(second.prefix(2)))!
        let dayOne: Int = Int(String(first.dropFirst(3).prefix(2)))!
        let dayTwo: Int = Int(String(second.dropFirst(3).prefix(2)))!
        let yearOne: Int = Int(String(first.dropFirst(6).prefix(2)))!
        let yearTwo: Int = Int(String(second.dropFirst(6).prefix(2)))!
        let hourOne: Int = Int(String(first.dropFirst(11).prefix(2)))!
        let hourTwo: Int = Int(String(second.dropFirst(11).prefix(2)))!
        let minuteOne: Int = Int(String(first.dropFirst(14).prefix(2)))!
        let minuteTwo: Int = Int(String(second.dropFirst(14).prefix(2)))!
        let secondOne: Int = Int(String(first.dropFirst(17).prefix(2)))!
        let secondTwo: Int = Int(String(second.dropFirst(17).prefix(2)))!
        
        let dayCountFromMonth: [Int] = [0,31,59,90,120,151,181,212,243,273,304,334]
        
        let minCov: Int = 60
        let hourCov: Int = minCov * 60
        let dayCov: Int = hourCov * 24
        
        let totSecondsOne: Int = secondOne + (minCov*minuteOne) + (hourCov*hourOne) + (dayCov*dayOne) + (dayCountFromMonth[monthOne-1]*dayCov)
        let totSecondsTwo: Int = secondTwo + (minCov*minuteTwo) + (hourCov*hourTwo) + (dayCov*dayTwo) + (dayCountFromMonth[monthTwo-1]*dayCov)
        
        if yearOne == yearTwo {
            return totSecondsOne - totSecondsTwo
        } else {
            let secondsInYear = 31536000
            return (secondsInYear-totSecondsTwo) + totSecondsOne
        }
    }
}
