//
//  MileageTracker+Strings.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 29/03/2021.
//

import Foundation

extension MileageTracker {
    /// These properties generate the strings for the average consumption, spending, dates, etc,
    /// to be presented in the views
    var averageConsumption: Double {
        (totalKM / totalLiters).rounded(toPlaces: 2)
    }

    var totalLiters: Double {
        refuels.map {$0.liters}.reduce(0, +)
    }

    var averageSpending: Double {
        (totalKM / totalFuelSpending).rounded(toPlaces: 2)
    }

    var totalSpending: Double {
        refuels.map {$0.money}.reduce(0) {$0 + $1}.rounded(toPlaces: 2)
    }

    var totalOtherCosts: Double {
        otherCosts.map {$0.value}.reduce(0, +).rounded(toPlaces: 2)
    }

    var averagePrice: Double {
        let totalMoney = refuels
            .map {$0.money}
            .reduce(0, +)
        let totalLiters = refuels
            .map {$0.liters}
            .reduce(0, +)
        return (totalMoney / totalLiters).rounded(toPlaces: 2)
    }

    var totalKM: Double {
        refuels.last?.totalKM ?? 0.0
    }

    var totalFuelSpending: Double {
        refuels.map {$0.money}.reduce(0, +)
    }

    var lastRefuel: Date {
        refuels.last?.creationDate ?? Calendar.current.date(byAdding: .day, value: -7, to: Date())!
    }
}
