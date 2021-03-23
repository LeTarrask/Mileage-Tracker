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

    var body: some Scene {
        WindowGroup {
                TabView {
                    MileageView(tracker: tracker) {
                        tracker.save()
                    }.tabItem {
                        Image(systemName: "drop.fill")
                        Text(NSLocalizedString("Refuels", comment: ""))
                    }
                    OtherCostsView(tracker: tracker) {
                        tracker.save()
                    }.tabItem {
                        Image(systemName: "wrench.and.screwdriver")
                        Text(NSLocalizedString("Other costs", comment: ""))
                    }
                    GraphicsView(tracker: tracker)
                        .tabItem {
                            Image(systemName: "list.star")
                            Text(NSLocalizedString("Stats", comment: ""))
                        }
                    SettingsView(tracker: tracker)
                        .tabItem {
                            Image(systemName: "gearshape")
                            Text(NSLocalizedString("Settings", comment: ""))
                        }
                }.edgesIgnoringSafeArea(.top)
            .onAppear {
                tracker.load()
            }
        }
    }
}
