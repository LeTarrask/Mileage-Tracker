//
//  Double+Rounded.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 22/07/2020.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
