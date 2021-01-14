//
//  RefuelModel.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 22/07/2020.
//

import SwiftUI

public struct Refuel: Hashable, Codable, Identifiable {
    public let id: UUID
    var kilometers: Double
    var liters: Double
    var money: Double
    var creationDate: Date

    
    init(id: UUID = UUID(), kilometers: Double, liters: Double, money: Double, creationDate: Date = Date()) {
        self.id = id
        self.kilometers = kilometers
        self.liters = liters
        self.money = money
        self.creationDate = creationDate
    }

    // MARK: VARIABLES TO STRING
    var kmString: String {
        return String(Int(round(kilometers)))
    }
    
    var literString: String {
        return String(liters.rounded(toPlaces: 2))
    }
    
    var moneyString: String {
        return String(money.rounded(toPlaces: 2))
    }
    
    var pricePerLiter: String {
        let price = money/liters
        return String(price.rounded(toPlaces: 2))
    }
}

extension Refuel {
    struct Data {
        var kilometers: Double = 0
        var liters: Double = 0
        var money: Double = 0
        
        var kmString: String = "" {
            didSet {
                kilometers = number(for: kmString)
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
        return Data(kilometers: kilometers, liters: liters, money: money)
    }
    
    mutating func update(from data: Data) {
        kilometers = data.kilometers
        liters = data.liters
        money = data.money
    }
}

extension Refuel {
    static var data: [Refuel] {
        [
         Refuel(kilometers: 194, liters: 6.5, money: 9.28),
         Refuel(kilometers: 378, liters: 4.74, money: 6.77),
         Refuel(kilometers: 547, liters: 4.2, money: 6.13),
         Refuel(kilometers: 733, liters: 4.96, money: 7.19),
         Refuel(kilometers: 919, liters: 4.53, money: 6.56),
         Refuel(kilometers: 1106, liters: 4.88, money: 7.07),
         Refuel(kilometers: 1260, liters: 4.17, money: 6),
         Refuel(kilometers: 1419, liters: 2.64, money: 3.8),
         Refuel(kilometers: 1606, liters: 4.87, money: 7.11),
         Refuel(kilometers: 1720, liters: 4.94, money: 7.6),
         Refuel(kilometers: 1906, liters: 5.1, money: 7.34),
         Refuel(kilometers: 2093, liters: 5.1, money: 7.34),
         Refuel(kilometers: 2283, liters: 5.33, money: 7.67),
         Refuel(kilometers: 2471, liters: 5.11, money: 7.46),
         Refuel(kilometers: 2658, liters: 5.04, money: 7.3),
         Refuel(kilometers: 2845, liters: 5.08, money: 7.21),
         Refuel(kilometers: 3047, liters: 5.39, money: 7.76),
         Refuel(kilometers: 3233, liters: 5, money: 7.20),
         Refuel(kilometers: 3606, liters: 5.36, money: 8.36)
        ]
    }
}


extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
