//
//  RefuelModel.swift
// Fuel Logue
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

    init(id: UUID = UUID(),
         totalKM: Double,
         liters: Double,
         money: Double,
         creationDate: Date = Date(),
         kmAdded: Double) {
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

    func number(for string: String) -> Double {
        let numberFormatter = NumberFormatter()

        return numberFormatter.number(from: string)?.doubleValue ?? 0.0
    }
}

extension Refuel {
    /// Provides an empty struct that's used to receive editable user's input before storage
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
            let numberFormatter = NumberFormatter()

            return numberFormatter.number(from: string)?.doubleValue ?? 0.0
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
