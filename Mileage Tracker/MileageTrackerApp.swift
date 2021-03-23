//
//  Mileage_TrackerApp.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 22/07/2020.
//

import SwiftUI

@main
struct MileageTrackerApp: App {
    @ObservedObject private var tracker = MileageTracker()
    
    /// VIEW STRINGS & URLs
    let refuelsString = NSLocalizedString("Refuels", comment: "")
    let otherCostsString = NSLocalizedString("Other costs", comment: "")
    let statsString = NSLocalizedString("Stats", comment: "")
    let settingsString = NSLocalizedString("Settings", comment: "")

    var body: some Scene {
        WindowGroup {
                TabView {
                    MileageView(tracker: tracker) {
                        tracker.save()
                    }.tabItem {
                        Image(systemName: "drop.fill")
                        Text(refuelsString)
                    }
                    OtherCostsView(tracker: tracker) {
                        tracker.save()
                    }.tabItem {
                        Image(systemName: "wrench.and.screwdriver")
                        Text(otherCostsString)
                    }
                    GraphicsView(tracker: tracker)
                        .tabItem {
                            Image(systemName: "list.star")
                            Text(statsString)
                        }
                    SettingsView(tracker: tracker)
                        .tabItem {
                            Image(systemName: "gearshape")
                            Text(settingsString)
                        }
                }.edgesIgnoringSafeArea(.top)
            .onAppear {
                tracker.load()
            }
        }
    }
}
