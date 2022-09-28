//
//  Extension Date Add + Subtract.swift
//  Mileage Tracker
//
//  Created by tarrask on 28/09/2022.
//

import Foundation

func addOrSubtractMonth(month: Int) -> Date {
    return Calendar.current.date(byAdding: .month, value: month, to: Date())!
}

func addOrSubtractYear(year: Int) -> Date {
    return Calendar.current.date(byAdding: .year, value: year, to: Date())!
}
