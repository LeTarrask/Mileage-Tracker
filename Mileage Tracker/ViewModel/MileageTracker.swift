//
//  MileageTracker.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 22/07/2020.
//

import SwiftUI

class MileageTracker: ObservableObject {
    /// A class to log and store in memory all information regarding refuelling and other vehicle costs.
    @Published var refuels: [Refuel] = [Refuel]()
    @Published var otherCosts: [OtherCost] = [OtherCost]()

    /// This method receives a data parameter from the view and adds it to our database
    /// - Parameter data: data contains kilometers, liters, and money paid in refuel,
    /// and calculates totalKm for the vehicle
    func receiveNew(_ data: Refuel.Data) {

        let newRefuel = Refuel(totalKM: data.totalKM,
                               liters: data.liters,
                               money: data.money,
                               kmAdded: data.totalKM - self.totalKM)
        refuels.append(newRefuel)
    }

    /// These 3 properties (documentsFolder, refuelsURL and costsURL are used to define where our app info is stored.
    /// These two methods (load() and save() are responsible for converting and storing our information in JSON
    private static var documentsFolder: URL {
        do {
            return try FileManager.default.url(for: .documentDirectory,
                                               in: .userDomainMask,
                                               appropriateFor: nil,
                                               create: false)
        } catch {
            fatalError("Can't find documents directory.")
        }
    }

    private static var refuelsURL: URL {
        return documentsFolder.appendingPathComponent("refuels.data")
    }

    private static var costsURL: URL {
        return documentsFolder.appendingPathComponent("costs.data")
    }

    func load() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let data = try? Data(contentsOf: Self.refuelsURL) else {
                #if DEBUG
                DispatchQueue.main.async {
                    self?.refuels = Refuel.data
                    print("refuelled")
                }
                #endif
                return
            }
            guard let costs = try? Data(contentsOf: Self.costsURL) else {
                #if DEBUG
                DispatchQueue.main.async {
                    self?.otherCosts = OtherCost.data
                    print("recosted")
                }
                #endif
                return
            }

            guard let refuels = try? JSONDecoder().decode([Refuel].self, from: data) else {
                fatalError("Can't decode saved refuel data.")
            }
            DispatchQueue.main.async {
                self?.refuels = refuels
            }

            guard let otherCosts = try? JSONDecoder().decode([OtherCost].self, from: costs) else {
                fatalError("Can't decode saved costs data.")
            }

            DispatchQueue.main.async {
                self?.otherCosts = otherCosts
            }
        }

        refuels.sort {
            $0.totalKM < $1.totalKM
        }
    }

    func save() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let refuels = self?.refuels else { fatalError("Self out of scope") }
            guard let data = try? JSONEncoder().encode(refuels) else { fatalError("Error encoding refuelsdata") }
            do {
                let outfile = Self.refuelsURL
                try data.write(to: outfile)
            } catch {
                fatalError("Can't write refuels to file")
            }

            guard let costs = self?.otherCosts else { fatalError("Self out of scope") }
            guard let costData = try? JSONEncoder().encode(costs) else { fatalError("Error encoding costs data") }
            do {
                let costFile = Self.costsURL
                try costData.write(to: costFile)
            } catch {
                fatalError("Can't write costs to file")
            }
        }
    }
}

extension MileageTracker {
    /// These properties generate the strings for the average consumption, spending, dates, etc,
    /// to be presented in the views
    var averageConsumption: Double {
        var average = 0.0
        if refuels.count > 1 {
            let totalKM = refuels.last?.totalKM
            let totalLiters = refuels
                .map {$0.liters}
                .reduce(0) {$0 + $1}
            average = ((totalKM ?? 0.0) / totalLiters).rounded(toPlaces: 2)
        }

        return average
    }

    var averageSpending: Double {
        var average = 0.0
        if refuels.count > 1 {
            let totalKM = refuels.last?.totalKM
            let totalMoney = refuels
                .map {$0.money}
                .reduce(0) {$0 + $1}
            average = ((totalKM ?? 0.0) / totalMoney).rounded(toPlaces: 2)
        }
        return average
    }

    var totalSpending: Double {
        var total = 0.0
        if refuels.count > 1 {
            let totalMoney = refuels
                                .map {$0.money}
                                .reduce(0) {$0 + $1}
            total = totalMoney.rounded(toPlaces: 2)
        }
        return total
    }

    var totalOtherCosts: Double {
        var total = 0.0
        if otherCosts.count > 1 {
            let totalCosts = otherCosts.map {$0.value}.reduce(0, +)
            total = totalCosts.rounded(toPlaces: 2)
        }
        return total
    }

    var averagePrice: Double {
        var average = 0.0
        if refuels.count > 1 {
            let totalMoney = refuels
                .map {$0.money}
                .reduce(0) {$0 + $1}
            let totalLiters = refuels
                .map {$0.liters}
                .reduce(0) {$0 + $1}
            average = (totalMoney / totalLiters).rounded(toPlaces: 2)
        }
        return average
    }

    var totalKM: Double {
        refuels.last?.totalKM ?? 0.0
    }

    var lastRefuel: Date {
        refuels.last?.creationDate ?? Calendar.current.date(byAdding: .day, value: -7, to: Date())!
    }
}
