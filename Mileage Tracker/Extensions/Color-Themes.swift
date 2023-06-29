/**
 Color-Themes.swift

 This file defines an enum `Theme` that represents different color themes for the Mileage Tracker app.

 Created by Alex Luna on 25/03/2021.
*/

import SwiftUI

/// Protocol for pickable items
typealias Pickable = CaseIterable & Identifiable & Hashable & CustomStringConvertible

/// Enum representing different color themes for the app
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
        case .theme4:
            return "Theme 4"
        }
    }

    case theme1, theme2, theme3, theme4

    /// The main color of the theme
    var mainColor: Color {
        colors["mainColor"]!
    }

    /// The background color of the theme
    var backgroundColor: Color {
        colors["backgroundColor"]!
    }

    /// The secondary color of the theme
    var secondColor: Color {
        colors["secondColor"]!
    }

    /// The highlight color of the theme
    var highlightColor: Color {
        colors["highlightColor"]!
    }

    /// The title text color of the theme
    var titleTextColor: Color {
        colors["titleTextColor"]!
    }

    /// The subtitle text color of the theme
    var subtitleTextColor: Color {
        colors["subtitleTextColor"]!
    }

    /// The gradient 1 of the theme
    var gradient1: Gradient {
        Gradient(colors: [highlightColor, mainColor])
    }

    /// The gradient 2 of the theme
    var gradient2: Gradient {
        Gradient(colors: [backgroundColor, highlightColor])
    }

    /// Dictionary of colors for each theme
    private var colors: [String: Color] {
        switch self {
        case .theme1:
            return [
                "mainColor": Color("mainColor"),
                "backgroundColor": Color("backgroundColor"),
                "secondColor": Color("secondColor"),
                "highlightColor": Color("highlightColor"),
                "titleTextColor": Color(UIColor.systemGray),
                "subtitleTextColor": Color(UIColor.systemGray3)
            ]
        case .theme2:
            return [
                "mainColor": Color("mainColor_0"),
                "backgroundColor": Color("backgroundColor_0"),
                "secondColor": Color("secondColor_0"),
                "highlightColor": Color("highlightColor_0"),
                "titleTextColor": Color(UIColor.systemGray4),
                "subtitleTextColor": Color(UIColor.systemGray)
            ]
        case .theme3:
            return [
                "mainColor": Color("mainColor_2"),
                "backgroundColor": Color("backgroundColor_2"),
                "secondColor": Color("secondColor_2"),
                "highlightColor": Color("highlightColor_2"),
                "titleTextColor": Color(UIColor.systemGray4),
                "subtitleTextColor": Color(UIColor.systemGray)
            ]
        case .theme4:
            return [
                "mainColor": Color("mainColor_1"),
                "backgroundColor": Color("backgroundColor_1"),
                "secondColor": Color("secondColor_1"),
                "highlightColor": Color("highlightColor_1"),
                "titleTextColor": Color(UIColor.systemGray4),
                "subtitleTextColor": Color(UIColor.systemGray)
            ]
        }
    }
}

// TODO: - Struct Implementation


//struct Theme {
//    
//    let theme1 = [
//        "mainColor": Color("mainColor_2"),
//        "backgroundColor": Color("backgroundColor_2"),
//        "secondColor": Color("secondColor_2"),
//        "highlightColor": Color("highlightColor_2"),
//        "titleTextColor": Color(UIColor.systemGray6),
//        "subtitleTextColor": Color(UIColor.systemGray)
//    ]
//    let theme2 = [
//        "mainColor": Color("mainColor_0"),
//        "backgroundColor": Color("backgroundColor_0"),
//        "secondColor": Color("secondColor_0"),
//        "highlightColor": Color("highlightColor_0"),
//        "titleTextColor": Color(UIColor.systemGray4),
//        "subtitleTextColor": Color(UIColor.systemGray)
//    ]
//    let theme3 = [
//        "mainColor": Color("mainColor_2"),
//        "backgroundColor": Color("backgroundColor_2"),
//        "secondColor": Color("secondColor_2"),
//        "highlightColor": Color("highlightColor_2"),
//        "titleTextColor": Color(UIColor.systemGray4),
//        "subtitleTextColor": Color(UIColor.systemGray)
//    ]
//    let theme4 = [
//        "mainColor": Color("mainColor_1"),
//        "backgroundColor": Color("backgroundColor_1"),
//        "secondColor": Color("secondColor_1"),
//        "highlightColor": Color("highlightColor_1"),
//        "titleTextColor": Color(UIColor.systemGray4),
//        "subtitleTextColor": Color(UIColor.systemGray)
//    ]
//}
