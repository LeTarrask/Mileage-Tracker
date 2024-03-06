//
//  Extension Date Add + Subtract.swift
//  Mileage Tracker
//
//  Created by tarrask on 28/09/2022.
//

import Foundation

/**
 Adds or subtracts the specified number of months to/from the current date.

 - Parameter month: The number of months to add or subtract. 
                    Use a positive value to add months and a negative value to subtract months.
 - Returns: The resulting date after adding or subtracting the specified number of months.
*/
func addOrSubtractMonth(month: Int) -> Date {
    return Calendar.current.date(byAdding: .month, value: month, to: Date())!
}

/**
 Adds or subtracts the specified number of years to/from the current date.

 - Parameter year:  The number of years to add or subtract. 
                    Use a positive value to add years and a negative value to subtract years.
 - Returns: The resulting date after adding or subtracting the specified number of years.
*/
func addOrSubtractYear(year: Int) -> Date {
    return Calendar.current.date(byAdding: .year, value: year, to: Date())!
}
