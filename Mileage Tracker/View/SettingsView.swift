//
//  SettingsView.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 18/01/2021.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var tracker: MileageTracker
    
    @Environment(\.openURL) var openURL
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Share Mileage Tracker")) {
                    Button("Copy App Link") { openURL(URL(string: "https://www.tarrask.com")!) }
                }
                
                Section(header: Text("Feedback")) {
                    Button("Rate us on the App Store") { openURL(URL(string: "https://www.tarrask.com")!) } // URL here FPO
                    Button("Take a survey") { openURL(URL(string: "https://www.tarrask.com")!) } // URL here FPO
                    Button("Talk to the developer") { openURL(URL(string: "https://www.tarrask.com")!) } // URL here FPO
                }
                
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
            .accentColor(.red)
            .navigationBarTitle("App Settings", displayMode: .inline)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(tracker: MileageTracker())
    }
}
