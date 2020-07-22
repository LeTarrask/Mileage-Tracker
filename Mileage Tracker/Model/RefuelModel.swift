//
//  RefuelModel.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 22/07/2020.
//

import SwiftUI

struct Refuel: Hashable {
    var kilometers: Double
    var liters: Double
    var money: Double
    
    var kmString: String {
        let string = String(kilometers.rounded(toPlaces: 2))
        return string + " kilometers"
    }
    
    var literString: String {
        let string = String(liters.rounded(toPlaces: 2))
        return string + " liters"
    }
    
    var moneyString: String {
        let string = String(money.rounded(toPlaces: 2))
        return string + " Euro"
    }
}
