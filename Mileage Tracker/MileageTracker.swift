//
//  MileageTracker.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 22/07/2020.
//

import SwiftUI

class MileageTracker: ObservableObject {
    @Published var refuels: [Refuel]
    
    init() {
        refuels = FakeData()
    }
    
    func storeNewRefuel(refuel: Refuel) {
        refuels.append(refuel)
    }
}

struct Refuel: Hashable {
    var kilometers: Double
    var liters: Double
    var money: Double
}

extension Refuel: CustomStringConvertible {
    var description: String {
        return "\(kilometers) kilometers, \(liters) liters, \(money) money, "
    }
}

func FakeData() -> [Refuel]{
    var refuels = [Refuel]()
    for _ in 1...8 {
        let km = Double.random(in: 10.0 ..< 20.0)
        let liters = Double.random(in: 10.0 ..< 20.0)
        let money = Double.random(in: 10.0 ..< 20.0)
        let fuel = Refuel(kilometers: km, liters: liters, money: money)
        refuels.append(fuel)
    }
    return refuels
}
