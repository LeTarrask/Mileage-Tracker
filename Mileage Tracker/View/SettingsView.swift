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
                Button("Delete all app data") {
                    tracker.refuels = [Refuel]()
                    tracker.otherCosts = [OtherCost]()
                    tracker.save()
                }
            }
            
            // Comment this section to publish app
            Section(header: Text("Test data")) {
                Button("Load test data") {
                    tracker.refuels = Refuel.data
                    tracker.otherCosts = OtherCost.data
                    tracker.save()
                }
            }
            
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(tracker: MileageTracker())
    }
}
