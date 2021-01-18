//
//  SettingsView.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 18/01/2021.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var tracker: MileageTracker
    
    var body: some View {
        Text("Hello, World!")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(tracker: MileageTracker())
    }
}
