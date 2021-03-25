//
//  EnumPicker.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 25/03/2021.
//

import SwiftUI

struct EnumPicker<Enum: Pickable, Label: View>: View {
    private let label: Label

    @Binding private var selection: Enum

    var body: some View {
        Picker(selection: $selection, label: label) {
            ForEach(Array(Enum.allCases)) { value in
                Text(value.description).tag(value)
            }
        }
    }

    init(selection: Binding<Enum>, label: Label) {
        self.label = label
        _selection = selection
    }
}
