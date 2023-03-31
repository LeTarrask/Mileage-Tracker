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
        case .theme4:
            return "Theme 4"
        }
    }

    case theme1, theme2, theme3, theme4
    
    var mainColor: Color {
        colors["mainColor"]!
    }

    var backgroundColor: Color {
        colors["backgroundColor"]!
    }

    var secondaryColor: Color {
        colors["secondaryColor"]!
    }

    var highlightColor: Color {
        colors["highlightColor"]!
    }

    var titleTextColor: Color {
        colors["titleTextColor"]!
    }

    var subtitleTextColor: Color {
        colors["subtitleTextColor"]!
    }

    var gradient1: Gradient {
        Gradient(colors: [highlightColor, mainColor])
    }

    var gradient2: Gradient {
        Gradient(colors: [backgroundColor, highlightColor])
    }

    private var colors: [String: Color] {
        switch self {
        case .theme1:
            return [
                "mainColor": Color("mainColor"),
                "backgroundColor": Color("backgroundColor"),
                "secondaryColor": Color("secondaryColor"),
                "highlightColor": Color("highlightColor"),
                "titleTextColor": Color(UIColor.systemGray),
                "subtitleTextColor": Color(UIColor.systemGray3)
            ]
        case .theme2:
            return [
                "mainColor": Color("mainColor_0"),
                "backgroundColor": Color("backgroundColor_0"),
                "secondaryColor": Color("secondaryColor_0"),
                "highlightColor": Color("highlightColor_0"),
                "titleTextColor": Color(UIColor.systemGray4),
                "subtitleTextColor": Color(UIColor.systemGray)
            ]
        case .theme3:
            return [
                "mainColor": Color("mainColor_2"),
                "backgroundColor": Color("backgroundColor_2"),
                "secondaryColor": Color("secondaryColor_2"),
                "highlightColor": Color("highlightColor_2"),
                "titleTextColor": Color(UIColor.systemGray4),
                "subtitleTextColor": Color(UIColor.systemGray)
            ]
        case .theme4:
            return [
                "mainColor": Color("mainColor_1"),
                "backgroundColor": Color("backgroundColor_1"),
                "secondaryColor": Color("secondaryColor_1"),
                "highlightColor": Color("highlightColor_1"),
                "titleTextColor": Color(UIColor.systemGray4),
                "subtitleTextColor": Color(UIColor.systemGray)
            ]
        }
    }
}
