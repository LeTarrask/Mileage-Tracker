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

    @Published var paidApp: Bool = true

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
        documentsFolder.appendingPathComponent("refuels.data")
    }

    private static var costsURL: URL {
        documentsFolder.appendingPathComponent("costs.data")
    }

    private static var csvURL: URL {
        documentsFolder.appendingPathComponent("tracker.csv")
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

    func exportCSV() {
        /// A method that exports Refuel data and other costs into a CSV file
        var refuelStrings = "Refuel Date, Liters, Price per Liter, km added, total km\n"

        let formatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            return formatter
        }()

        for refuel in refuels {
            let array = [formatter.string(from: refuel.creationDate),
                         String(refuel.liters),
                         String(refuel.pricePerLiter),
                         String(refuel.kmAdded),
                         String(refuel.totalKM),
                         "\n"]
            let line = array.joined(separator: ",")
            refuelStrings.append(line)
        }

        /// Iterates other costs
        refuelStrings.append("\nCost Date, Type, Name, Price\n")

        for cost in otherCosts {
            let array = [formatter.string(from: cost.creationDate),
                         cost.type.rawValue,
                         cost.name,
                         String(cost.value),
                         "\n"]
            let line = array.joined(separator: ",")
            refuelStrings.append(line)
        }
        do {
            try refuelStrings.write(to: Self.csvURL, atomically: true, encoding: .utf8)
        } catch {
            print("Failed to create file")
            print("\(error)")
        }
    }

    func csvFile() -> URL {
        exportCSV()
        return Self.csvURL
    }
}

extension MileageTracker {
    /// Testing methods
    func deleteData() {
        refuels = [Refuel]()
        otherCosts = [OtherCost]()
        save()
        if UserDefaults.standard.bool(forKey: "didLaunchBefore") {
            UserDefaults.standard.set(false, forKey: "didLaunchBefore")
        }
    }

    func loadTestData() {
        refuels = Refuel.data
        otherCosts = OtherCost.data
        save()
    }
}

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
