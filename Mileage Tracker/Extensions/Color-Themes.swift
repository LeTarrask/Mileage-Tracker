//
//  Color-Themes.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 25/03/2021.
//

import SwiftUI

typealias Pickable = CaseIterable & Identifiable & Hashable & CustomStringConvertible

enum Theme: Int, Pickable {
    var id: Self { self }

    var description: String {
        switch self {
        case .theme1:
            return "Theme 1"
        case .theme2:
            return "Theme 2"
        case .theme3:
            return "Theme 3"
        }
    }

    case theme1, theme2, theme3

    var mainColor: Color {
        switch self {
        case .theme1:
            return Color("mainColor")
        case .theme2:
            return Color("mainColor_1")
        case .theme3:
            return Color("mainColor_2")
        }
    }

    var backgroundColor: Color {
        switch self {
        case .theme1:
            return Color("backgroundColor")
        case .theme2:
            return Color("backgroundColor_1")
        case .theme3:
            return Color("backgroundColor_2")
        }
    }

    var secondaryColor: Color {
        switch self {
        case .theme1:
            return Color("secondaryColor")
        case .theme2:
            return Color("secondaryColor_1")
        case .theme3:
            return Color("secondaryColor_2")
        }
    }

    var highlightColor: Color {
        switch self {
        case .theme1:
            return Color("highlightColor")
        case .theme2:
            return Color("highlightColor_1")
        case .theme3:
            return Color("highlightColor_2")
        }
    }

    var titleTextColor: Color {
        switch self {
        case .theme1:
            return Color(UIColor.systemGray)
        case .theme2:
            return Color(UIColor.systemGray4)
        case .theme3:
            return Color(UIColor.systemGray4)
        }
    }

    var subtitleTextColor: Color {
        switch self {
        case .theme1:
            return Color(UIColor.systemGray3)
        case .theme2:
            return Color(UIColor.systemGray)
        case .theme3:
            return Color(UIColor.systemGray)
        }
    }

    var gradient1: Gradient {
        Gradient(colors: [highlightColor, mainColor])
    }

    var gradient2: Gradient {
        Gradient(colors: [backgroundColor, highlightColor])
    }
}
