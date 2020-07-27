//
//  MileageTracker.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 22/07/2020.
//

import SwiftUI

class MileageTracker: ObservableObject {    
    @Published var refuels: [Refuel] = [Refuel]()
    
    let filesManager: FilesManager = FilesManager()
    
    
    init() {
        if let storedData = try? filesManager.getDecoded() {
            print("Stored Data")
            print(storedData)
            refuels = storedData
        }
    }
    
    var averageConsumption: String {
        get {
            var average = 0.0
            if refuels.count > 1 {
                let totalKM = refuels
                    .map{$0.kilometers}
                    .reduce(0) {$0 + $1}
                let totalLiters = refuels
                    .map{$0.liters}
                    .reduce(0) {$0 + $1}
                average = (totalKM / totalLiters).rounded(toPlaces: 2)
            }
            
            return String(average)
        }
    }
    
    var averageSpending: String {
        get {
            var average = 0.0
            if refuels.count > 1 {
                let totalKM = refuels
                    .map{$0.kilometers}
                    .reduce(0) {$0 + $1}
                let totalMoney = refuels
                    .map{$0.money}
                    .reduce(0) {$0 + $1}
                average = (totalKM / totalMoney).rounded(toPlaces: 2)
            }
            
            return String(average)
        }
    }
    
    func storeNewRefuel(refuel: Refuel) {
        refuels.append(refuel)
        try? filesManager.save(input: refuels)
    }
}

func FakeData() -> [Refuel]{
    var refuels = [Refuel]()
    for _ in 1...10 {
        let km = Double.random(in: 110.0 ..< 200.0)
        let liters = Double.random(in: 3.0 ..< 7.0)
        let money = Double.random(in: 4.0 ..< 8.0)
        let fuel = Refuel(kilometers: km, liters: liters, money: money)
        refuels.append(fuel)
    }
    return refuels
}
