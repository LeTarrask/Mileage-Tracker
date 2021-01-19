//
//  RefuelModel.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 22/07/2020.
//

import SwiftUI

public struct Refuel: Hashable, Codable, Identifiable {
    public let id: UUID
    var totalKM: Double
    var liters: Double
    var money: Double
    var creationDate: Date
    var kmAdded: Double

    
    init(id: UUID = UUID(), totalKM: Double, liters: Double, money: Double, creationDate: Date = Date(), kmAdded: Double) {
        self.id = id
        self.totalKM = totalKM
        self.liters = liters
        self.money = money
        self.creationDate = creationDate
        self.kmAdded = kmAdded
    }
    
    var pricePerLiter: Double {
        (money/liters).rounded(toPlaces: 2)
    }
}

extension Refuel {
    struct Data {
        var totalKM: Double = 0
        var liters: Double = 0
        var money: Double = 0
        
        var kmString: String = "" {
            didSet {
                totalKM = number(for: kmString)
            }
        }
        var litersString: String = "" {
            didSet {
                liters = number(for: litersString)
            }
        }
        var moneyString: String = "" {
            didSet {
                money = number(for: moneyString)
            }
        }
        
        func number(for string: String) -> Double {
            let nf = NumberFormatter()
            
            return nf.number(from: string)?.doubleValue ?? 0.0
        }
    }
    
    var data: Data {
        return Data(totalKM: totalKM, liters: liters, money: money)
    }
    
    mutating func update(from data: Data) {
        totalKM = data.totalKM
        liters = data.liters
        money = data.money
    }
}

extension Refuel {
    static var data: [Refuel] {
        [
            Refuel(totalKM: 194, liters: 6.5, money: 9.28, kmAdded: 194),
            Refuel(totalKM: 378, liters: 4.74, money: 6.77, kmAdded: 184),
            Refuel(totalKM: 547, liters: 4.2, money: 6.13, kmAdded: 169),
            Refuel(totalKM: 733, liters: 4.96, money: 7.19, kmAdded: 186),
            Refuel(totalKM: 919, liters: 4.53, money: 6.56, kmAdded: 186),
            Refuel(totalKM: 1106, liters: 4.88, money: 7.07, kmAdded: 187),
            Refuel(totalKM: 1260, liters: 4.17, money: 6, kmAdded: 154),
            Refuel(totalKM: 1419, liters: 2.64, money: 3.8, kmAdded: 159),
            Refuel(totalKM: 1606, liters: 4.87, money: 7.11, kmAdded: 187),
            Refuel(totalKM: 1720, liters: 4.94, money: 7.6, kmAdded: 114),
            Refuel(totalKM: 1906, liters: 5.1, money: 7.34, kmAdded: 186),
            Refuel(totalKM: 2093, liters: 5.1, money: 7.34, kmAdded: 187),
            Refuel(totalKM: 2283, liters: 5.33, money: 7.67, kmAdded: 190),
            Refuel(totalKM: 2471, liters: 5.11, money: 7.46, kmAdded: 188),
            Refuel(totalKM: 2658, liters: 5.04, money: 7.3, kmAdded: 187),
            Refuel(totalKM: 2845, liters: 5.08, money: 7.21, kmAdded: 187),
            Refuel(totalKM: 3047, liters: 5.39, money: 7.76, kmAdded: 202),
            Refuel(totalKM: 3233, liters: 5, money: 7.20, kmAdded: 186),
            Refuel(totalKM: 3419, liters: 5.36, money: 8.36, kmAdded: 186),
            Refuel(totalKM: 3606, liters: 5.36, money: 8.36, kmAdded: 186)
        ]
    }
}



