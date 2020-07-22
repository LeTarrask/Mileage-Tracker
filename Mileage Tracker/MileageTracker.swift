//
//  MileageTracker.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 22/07/2020.
//

import Foundation

class MileageTracker {
    var refuels: [Refuel]
    
    init() {
        refuels = FakeData()
    }
}

struct Refuel {
    var kilometer: Double
    var liters: Double
    var money: Double
}

func FakeData() -> [Refuel]{
    var refuels = [Refuel]()
    for _ in 1...8 {
        let km = Double.random(in: 10.0 ..< 20.0)
        let liters = Double.random(in: 10.0 ..< 20.0)
        let money = Double.random(in: 10.0 ..< 20.0)
        let fuel = Refuel(kilometer: km, liters: liters, money: money)
        refuels.append(fuel)
    }
    return refuels
}
