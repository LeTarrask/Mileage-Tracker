//
//  ViewRouter.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 26/03/2021.
//

import SwiftUI

class ViewRouter: ObservableObject {
    @Published var currentPage: Page = .mileage
    
    static let shared = ViewRouter()

    enum Page: Hashable {
        case mileage
        case othercosts
        case graphics
        case settings
        case addobject
    }
}
