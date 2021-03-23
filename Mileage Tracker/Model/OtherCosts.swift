//
//  OtherCosts.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 15/01/2021.
//

import Foundation

struct OtherCost: Hashable, Identifiable, Codable {
    /// A data storage type to save other kinds of costs a vehicle may have.
    var id: UUID
    var type: CostType
    var value: Double
    var creationDate: Date
    var name: String

    init(type: CostType, value: Double, name: String) {
        self.id = UUID()
        self.type = type
        self.value = value
        self.creationDate = Date()
        self.name = name
    }

    enum CostType: String, CaseIterable, Equatable, Codable {
        case tax
        case maintenance

        enum Key: CodingKey {
            case rawValue
        }
        enum CodingError: Error {
            case unknownValue
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: Key.self)
            let rawValue = try container.decode(Int.self, forKey: .rawValue)
            switch rawValue {
            case 0:
                self = .tax
            case 1:
                self = .maintenance
            default:
                throw CodingError.unknownValue
            }
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: Key.self)
            switch self {
            case .tax:
                try container.encode(0, forKey: .rawValue)
            case .maintenance:
                try container.encode(1, forKey: .rawValue)
            }
        }
    }
}

extension OtherCost {
    /// Provides an empty othercost that can be edited by the user before being stored permanently in the model
    struct Data {
        var type: CostType = .maintenance
        var value: Double = 0
        var name: String = ""

        var valueString: String = "" {
            didSet {
                value = number(for: valueString)
            }
        }

        func number(for string: String) -> Double {
            let nf = NumberFormatter()

            return nf.number(from: string)?.doubleValue ?? 0.0
        }
    }

    var data: Data {
        return Data(type: type, value: value, name: name)
    }

    mutating func update(from data: Data) {
        type = data.type
        value = data.value
        name = data.name
    }
}

extension OtherCost {
    /// Provides fake data for testing purposes
    static var data: [OtherCost] {
        [
            OtherCost(type: .tax, value: 200, name: "IVA"),
            OtherCost(type: .maintenance, value: 20.1, name: "Revisao"),
            OtherCost(type: .tax, value: 43, name: "Selo"),
            OtherCost(type: .tax, value: 9.9, name: "Multa"),
            OtherCost(type: .maintenance, value: 12.3, name: "Troca Oleo")
        ]
    }
}
