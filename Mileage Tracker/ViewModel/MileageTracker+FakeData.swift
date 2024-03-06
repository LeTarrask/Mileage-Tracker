//
//  MileageViewModel+FakeData.swift
// Fuel Logue
//
//  Created by tarrask on 08/02/2023.
//

import Foundation

/// Data generation for testing methods
extension MileageViewModel {
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
        recalculateStats()
        refuels.sort {
            $0.creationDate < $1.creationDate
        }
        save()
    }
}
