//
//  ViewRouter.swift
// Fuel Logue
//
//  Created by Alex Luna on 26/03/2021.
//

import SwiftUI

/**
`ViewRouter` is an observable object that manages the current page in the app.
*/
class ViewRouter: ObservableObject {
    
    /// The current page in the app.
    @Published var currentPage: Page = .mileage

    /**
    The possible pages in the app.
    */
    enum Page: Hashable {
        case mileage
        case othercosts
        case graphics
        case settings
        case addobject
    }
}
