//
//  MileageViewModel+CSV.swift
// Fuel Logue
//
//  Created by tarrask on 08/02/2023.
//

import Foundation

/**
 Extension for `MileageViewModel` that provides methods for handling CSV files.
 */
extension MileageViewModel {
    
    /**
    The URL of the CSV file.

    - Returns: The URL of the CSV file.
    */
    private static var csvURL: URL {
        documentsFolder.appendingPathComponent("tracker.csv")
    }

    /**
    Generates a CSV string containing the refuel and other cost data.

    - Returns: A CSV string representing the refuel and other cost data.
    */
    func generateCSV() -> String {
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
        return refuelStrings
    }

    /**
    Writes the CSV file to disk.

    - Returns: The URL of the generated CSV file.
    */
    func csvFile() -> URL {
        let csvString = generateCSV()
        do {
            try csvString.write(to: Self.csvURL, atomically: true, encoding: .utf8)
        } catch {
            print("Failed to create file")
            print("\(error)")
        }
        return Self.csvURL
    }
}
