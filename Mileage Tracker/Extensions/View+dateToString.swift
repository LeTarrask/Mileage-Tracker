//
//  View+dateToString.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 25/03/2021.
//

import SwiftUI

extension View {
    func dateToString(date: Date) -> String {
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .medium
        return formatter1.string(from: date)
    }
}
