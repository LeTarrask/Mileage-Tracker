//
//  Theme Manager.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 25/03/2021.
//

import SwiftUI

class SettingsManager: ObservableObject {
    static let shared = SettingsManager()

    @Published var theme: Theme = Theme.theme1
    
    @AppStorage("ChosenDistance") var chosenDistance: String = "km"
    @AppStorage("ChosenVolume") var chosenVolume: String = "L"
    @AppStorage("Currency") var chosenCurrency: String = "€"
    @AppStorage("MeasureUnit") var chosenMeasure: String = ""

    private init() {
        self.theme = currentTheme()
    }
    

    // MARK: - Manages Color Theme
    
    private let selectedThemeKey = "SelectedTheme"
    
    /// This loads from UserDefalts the selected theme, or picks the main theme
    private func currentTheme() -> Theme {
        if let storedTheme = (UserDefaults.standard.value(forKey: selectedThemeKey) as AnyObject).integerValue {
            return Theme(rawValue: storedTheme)!
        } else {
            return .theme1
        }
    }

    /// Gets chosen theme and applies to our view's settings.
    func applyTheme(theme: Theme) {
        // First persist the selected theme using NSUserDefaults.
        UserDefaults.standard.setValue(theme.rawValue, forKey: selectedThemeKey)
        UserDefaults.standard.synchronize()

        self.theme = theme

        print("Storing theme choice: " + theme.description)
    }
}
