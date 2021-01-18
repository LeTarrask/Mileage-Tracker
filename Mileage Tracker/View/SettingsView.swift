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
        Form {
            Section(header: Text("Reset app")) {
                Button(action: {
                        tracker.refuels = [Refuel]()
                        tracker.otherCosts = [OtherCost]()
                        tracker.save() }, label: {
                    Text("Delete all app data")
                })
                
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(tracker: MileageTracker())
    }
}
