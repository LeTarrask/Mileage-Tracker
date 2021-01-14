//
//  MileageTracker.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 22/07/2020.
//

import SwiftUI

class MileageTracker: ObservableObject {
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
    
    private static var fileURL: URL {
        return documentsFolder.appendingPathComponent("refuels.data")
    }
    
    @Published var refuels: [Refuel] = [Refuel]()
    
    func load() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let data = try? Data(contentsOf: Self.fileURL) else {
                #if DEBUG
                DispatchQueue.main.async {
                    self?.refuels = Refuel.data
                    print("refuelled")
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
        }
        
        refuels.sort {
            $0.kilometers < $1.kilometers
        }
    }
    
    func save() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let refuels = self?.refuels else { fatalError("Self out of scope") }
            guard let data = try? JSONEncoder().encode(refuels) else { fatalError("Error encoding data") }
            do {
                let outfile = Self.fileURL
                try data.write(to: outfile)
            } catch {
                fatalError("Can't write to file")
            }
        }
    }
    
    var averageConsumption: String {
        get {
            var average = 0.0
            if refuels.count > 1 {
                let totalKM = refuels.last?.kilometers
                let totalLiters = refuels
                    .map{$0.liters}
                    .reduce(0) {$0 + $1}
                average = ((totalKM ?? 0.0) / totalLiters).rounded(toPlaces: 2)
            }
            
            return String(average)
        }
    }
    
    var averageSpending: String {
        get {
            var average = 0.0
            if refuels.count > 1 {
                let totalKM = refuels.last?.kilometers
                let totalMoney = refuels
                    .map{$0.money}
                    .reduce(0) {$0 + $1}
                average = ((totalKM ?? 0.0) / totalMoney).rounded(toPlaces: 2)
            }
            return String(average)
        }
    }
    
    var totalSpending: String {
        get {
            var total = 0.0
            if refuels.count > 1 {
                let totalMoney = refuels
                    .map{$0.money}
                    .reduce(0) {$0 + $1}
                total = totalMoney.rounded(toPlaces: 2)
            }
            return String(total)
        }
    }
    
    var averagePrice: String {
        get {
            var average = 0.0
            if refuels.count > 1 {
                let totalMoney = refuels
                    .map{$0.money}
                    .reduce(0) {$0 + $1}
                let totalLiters = refuels
                    .map{$0.liters}
                    .reduce(0) {$0 + $1}
                average = (totalMoney / totalLiters).rounded(toPlaces: 2)
            }
            return String(average)
        }
    }
}
