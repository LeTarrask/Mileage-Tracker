//
//  View+dateToString.swift
// Fuel Logue
//
//  Created by Alex Luna on 25/03/2021.
//

import SwiftUI

extension View {
    // Method to convert a Date object to a string representation
    func dateToString(date: Date) -> String {
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .medium
        return formatter1.string(from: date)
    }
}
