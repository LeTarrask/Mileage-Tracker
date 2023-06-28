//
//  MeasureUnits.swift
//  Fuel Logue
//
//  Created by tarrask on 28/06/2023.
//

import Foundation
import SwiftUI


enum MeasureUnits: String, CaseIterable, Equatable {
    var id: Self { self }
    
    case imperial, metric
    
    var volume: String {
        switch self {
        case .imperial:
            return "gl"
        case .metric:
            return "L"
        }
    }
    
    var distance: String {
        switch self {
        case .imperial:
            return "mi"
        case .metric:
            return "km"
        }
    }
}
