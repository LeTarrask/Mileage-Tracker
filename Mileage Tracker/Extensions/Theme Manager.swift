//
//  Theme Manager.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 25/03/2021.
//

import Foundation

class ThemeManager {
    static let selectedThemeKey = "SelectedTheme"

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

        print("Storing theme choice: " + theme.description)
    }
}
