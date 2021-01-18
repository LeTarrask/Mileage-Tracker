//
//  Mileage_TrackerApp.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 22/07/2020.
//

import SwiftUI

@main
struct Mileage_TrackerApp: App {
    @ObservedObject private var tracker = MileageTracker()
        
    var body: some Scene {
        WindowGroup {
                TabView() {
                    MileageView(tracker: tracker) {
                        tracker.save()
                    }.tabItem {
                        Image(systemName: "drop.fill")
                        Text("Refuels")
                    }
                    OtherCostsView(tracker: tracker){
                        tracker.save()
                    }.tabItem {
                        Image(systemName: "wrench.and.screwdriver")
                        Text("Other costs")
                    }
                    GraphicsView(tracker: tracker)
                        .tabItem {
                            Image(systemName: "list.star")
                            Text("Stats")
                        }
                    SettingsView(tracker: tracker)
                        .tabItem {
                            Image(systemName: "gearshape")
                            Text("Settings")
                        }
                }.edgesIgnoringSafeArea(.top)
            .onAppear {
                tracker.load()
            }
        }
    }
}

