//
//  ThemePicker.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 25/03/2021.
//

import SwiftUI

struct ThemePicker: View {
    @State var chosenTheme: Theme = .theme1

    var body: some View {
        VStack {
            EnumPicker(selection: $chosenTheme, label: Text("Theme"))
            Text("Chosen theme: " + String(chosenTheme.description))
        }
    }
}

struct ThemePicker_Previews: PreviewProvider {
    static var previews: some View {
        ThemePicker()
    }
}
