//
//  ExtensionFloat+String.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 15/01/2021.
//

import Foundation

extension Double {
    /**
     Provides a computed property to format a Double as a clean string representation. It removes trailing decimal places from whole numbers, while preserving the decimal places for non-whole numbers.
     */
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
