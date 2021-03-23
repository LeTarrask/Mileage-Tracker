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
                Section(header: Text(NSLocalizedString("Share Mileage Tracker", comment: ""))) {
                    Button(NSLocalizedString("Copy App Link", comment: "")) { openURL(URL(string: "https://www.tarrask.com")!) }
                }

                Section(header: Text(NSLocalizedString("Feedback", comment: ""))) {
                    Button(NSLocalizedString("Rate us on the App Store", comment: "")) { openURL(URL(string: "https://www.tarrask.com")!) } // URL here FPO
                    Button(NSLocalizedString("Take a survey", comment: "")) { openURL(URL(string: "https://www.tarrask.com")!) } // URL here FPO
                    Button(NSLocalizedString("Talk to the developer", comment: "")) { openURL(URL(string: "https://www.tarrask.com")!) } // URL here FPO
                }

                Section(header: Text(NSLocalizedString("Reset app", comment: ""))) {
                    Button(NSLocalizedString("Delete all app data", comment: "")) {
                        tracker.refuels = [Refuel]()
                        tracker.otherCosts = [OtherCost]()
                        tracker.save()
                    }
                }

                // Comment this section to publish app
                Section(header: Text(NSLocalizedString("Test data", comment: ""))) {
                    Button(NSLocalizedString("Load test data", comment: "")) {
                        tracker.refuels = Refuel.data
                        tracker.otherCosts = OtherCost.data
                        tracker.save()
                    }
                }
            }
            .accentColor(.red)
            .navigationBarTitle(NSLocalizedString("App Settings", comment: ""), displayMode: .inline)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(tracker: MileageTracker())
    }
}
