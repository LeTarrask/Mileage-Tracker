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
    
    func recalculateStats() {
        calculateAverageConsumption()
        calculateTotalLiters()
        calculateAverageSpending()
        calculateTotalSpending()
        calculateTotalOtherCosts()
        calculateAveragePrice()
        calculateTotalKM()
        calculateTotalFuelSpending()
        searchLastRefuel()
    }
    
    func calculateAverageConsumption() {
        if refuels.isEmpty {
            averageConsumption = 0
        } else {
            averageConsumption = (totalKM / totalLiters).rounded(toPlaces: 2)
        }
    }

    func calculateTotalLiters() {
        totalLiters = refuels.map {$0.liters}.reduce(0, +)
    }

    func calculateAverageSpending() {
        if refuels.isEmpty {
            averageSpending = 0
        } else {
            averageSpending = (totalKM / totalFuelSpending).rounded(toPlaces: 2)
        }
    }

    func calculateTotalSpending() {
        totalSpending = refuels.map {$0.money}.reduce(0) {$0 + $1}.rounded(toPlaces: 2)
    }

    func calculateTotalOtherCosts() {
        totalOtherCosts = otherCosts.map {$0.value}.reduce(0, +).rounded(toPlaces: 2)
    }
    
    func calculateAveragePrice() {
        if refuels.isEmpty {
            averagePrice = 0
        } else {
            let totalMoney = refuels
                .map {$0.money}
                .reduce(0, +)
            let totalLiters = refuels
                .map {$0.liters}
                .reduce(0, +)
            averagePrice = (totalMoney / totalLiters).rounded(toPlaces: 2)
        }
    }

    func calculateTotalKM() {
        totalKM = refuels.last?.totalKM ?? 0.0
    }

    func calculateTotalFuelSpending() {
        totalFuelSpending = refuels.map {$0.money}.reduce(0, +)
    }

    func searchLastRefuel() {
        lastRefuel = refuels.last?.creationDate ?? Calendar.current.date(byAdding: .day, value: -7, to: Date())!
    }
}
