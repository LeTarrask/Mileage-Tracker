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
            NavigationView {
                TabView {
                    MileageView(tracker: tracker) {
                        tracker.save()
                    }
                    OtherCostsView(tracker: tracker){
                        tracker.save()
                    }
                    GraphicsView(tracker: tracker)
                }
            }
            .onAppear {
                tracker.load()
            }
            
        }
    }
}
