//
//  MileageTracker.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 22/07/2020.
//

import SwiftUI

/**
 The `MileageTracker` class is used to log and store in-memory information regarding refueling and other vehicle costs.

 ## Usage Example ##
 let mileageTracker = MileageTracker.shared
 mileageTracker.receiveNew(refuelData)
 
 - Note: This class is implemented as a singleton, accessible through the `shared` property.

 - Important: Make sure to call the `save()` method to persist the data before terminating the application.

 - SeeAlso: `Refuel`, `OtherCost`
 **/
class MileageTracker: ObservableObject {

    /// An array of `Refuel` objects representing the refueling events.
    @Published var refuels: [Refuel] = [Refuel]()
    
    /// An array of `OtherCost` objects representing other vehicle costs.
    @Published var otherCosts: [OtherCost] = [OtherCost]()
    
    /// Properties used to track the consumption
    @Published var averageConsumption: Double = 0
    @Published var totalLiters: Double = 0
    @Published var averageSpending: Double = 0
    @Published var totalSpending: Double = 0
    @Published var totalOtherCosts: Double = 0
    @Published var averagePrice: Double = 0
    @Published var totalKM: Double = 0
    @Published var totalFuelSpending: Double = 0
    @Published var lastRefuel: Date = Date()
    
    @Published var paidApp: Bool = false
    
    /// The shared instance of the `MileageTracker` class.
    static let shared = MileageTracker()
    
    /// This method receives a data parameter from the view and adds it to our database
    /// - Parameter data: data contains kilometers, liters, and money paid in refuel,
    /// and calculates totalKm for the vehicle
    func receiveNew(_ data: Refuel.Data) {
        
        let newRefuel = Refuel(totalKM: data.totalKM,
                               liters: data.liters,
                               money: data.money,
                               kmAdded: data.totalKM - self.totalKM)
        refuels.append(newRefuel)
        recalculateStats()
    }
    
    // MARK: - Data Persistence
    /// These 3 properties (documentsFolder, refuelsURL and costsURL are used to define where our app info is stored.
    /// These two methods (load() and save() are responsible for converting and storing our information in JSON
    static var documentsFolder: URL {
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
    
    init() {
        load()
    }

    /**
        Loads the saved data from disk.

        - Important: This method is called automatically during initialization.

        - SeeAlso: `save()`
    */
    private func load() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let data = try? Data(contentsOf: Self.refuelsURL) else {
                #if targetEnvironment(simulator)
                DispatchQueue.main.async {
                    self?.refuels = Refuel.data
                    print("refuelled")
                }
                #endif
                return
            }
            guard let costs = try? Data(contentsOf: Self.costsURL) else {
                #if targetEnvironment(simulator)
                DispatchQueue.main.async {
                    self?.otherCosts = OtherCost.data
                    print("recosted")
                    self?.recalculateStats()
                }
                #endif
                return
            }

            guard let refuels = try? JSONDecoder().decode([Refuel].self, from: data) else {
                fatalError("Can't decode saved refuel data.")
            }
            DispatchQueue.main.async {
                self?.refuels = refuels
                self?.recalculateStats()
            }

            guard let otherCosts = try? JSONDecoder().decode([OtherCost].self, from: costs) else {
                fatalError("Can't decode saved costs data.")
            }

            DispatchQueue.main.async {
                self?.otherCosts = otherCosts
                self?.recalculateStats()
            }
        }

        refuels.sort {
            $0.creationDate < $1.creationDate
        }
        
    }

    /**
        Saves the data to disk.

        - Important: This method should be called to persist the data before terminating the application.
    */
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
