//
//  OtherCost+FakeData.swift
//  Mileage Tracker
//
//  Created by tarrask on 08/02/2023.
//

import Foundation

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
