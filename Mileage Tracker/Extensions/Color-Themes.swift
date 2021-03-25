//
//  Color-Themes.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 25/03/2021.
//

import SwiftUI

typealias Pickable = CaseIterable & Identifiable & Hashable & CustomStringConvertible

enum Theme: Int, Pickable {
    // swiftlint:disable identifier_name
    var id: Self { self }

    var description: String {
        switch self {
        case .theme1:
            return "Theme 1"
        case .theme2:
            return "Theme 2"
        }
    }

    case theme1, theme2

    var mainColor: Color {
        // TO DO: Decide for color schemes and add all colors here.
        // Add all colors to the app here
        // Call these colors from view
        switch self {
        case .theme1:
            return Color("Wine")
        case .theme2:
            return Color("Wine")
        }
    }

    var backgroundColor: Color {
        // the same
        switch self {
        case .theme1:
            return Color("Wine")
        case .theme2:
            return Color("Wine")
        }
    }

    var secondaryColor: Color {
        switch self {
        case .theme1:
            return Color("Wine")
        case .theme2:
            return Color("Wine")
        }
    }

    var titleTextColor: Color {
        switch self {
        case .theme1:
            return Color("Wine")
        case .theme2:
            return Color("Wine")
        }
    }

    var subtitleTextColor: Color {
        switch self {
        case .theme1:
            return Color("Wine")
        case .theme2:
            return Color("Wine")
        }
    }
}

// Enum declaration
let selectedThemeKey = "SelectedTheme"

class ThemeManager {
    /// This loads from UserDefalts the selected theme, or picks the main theme
    static func currentTheme() -> Theme {
        if let storedTheme = (UserDefaults.standard.value(forKey: selectedThemeKey) as AnyObject).integerValue {
            return Theme(rawValue: storedTheme)!
        } else {
            return .theme1
        }
    }

    /// Gets chosen theme and applies to our view's settings.
    static func applyTheme(theme: Theme) {
        // First persist the selected theme using NSUserDefaults.
        UserDefaults.standard.setValue(theme.rawValue, forKey: selectedThemeKey)
        UserDefaults.standard.synchronize()

// You get your current (selected) theme and apply the main color to the
// tintColor property of your application’s window.
    }
}
