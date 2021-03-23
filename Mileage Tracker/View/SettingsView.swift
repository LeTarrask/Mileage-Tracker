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

    /// VIEW STRINGS & URLs
    let viewTitle = NSLocalizedString("App Settings", comment: "")
    let shareTracker = NSLocalizedString("Share Mileage Tracker", comment: "")
    let copyAppLink = NSLocalizedString("Copy App Link", comment: "")
    let appLink = URL(string: "https://www.tarrask.com")!
    let feedback = NSLocalizedString("Feedback", comment: "")
    let rateUs = NSLocalizedString("Rate us on the App Store", comment: "")
    let rateLink = URL(string: "https://www.tarrask.com")!
    let survey = NSLocalizedString("Take a survey", comment: "")
    let surveyLink = URL(string: "https://www.tarrask.com")!
    let talkToUs = NSLocalizedString("Talk to the developer", comment: "")
    let talkLink = URL(string: "https://www.tarrask.com")!
    let resetApp = NSLocalizedString("Reset app", comment: "")
    let deleteData = NSLocalizedString("Delete all app data", comment: "")
    let testData = NSLocalizedString("Test data", comment: "")
    let loadTestData = NSLocalizedString("Load test data", comment: "")

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text(shareTracker)) {
                    Button(copyAppLink) { openURL(appLink) }
                }

                Section(header: Text(feedback)) {
                    Button(rateUs) { openURL(rateLink) }
                    Button(survey) { openURL(surveyLink) }
                    Button(talkToUs) { openURL(talkLink) }
                }

                Section(header: Text(resetApp)) {
                    Button(deleteData) {
                        tracker.refuels = [Refuel]()
                        tracker.otherCosts = [OtherCost]()
                        tracker.save()
                    }
                }

                // Comment this section to publish app
                Section(header: Text(testData)) {
                    Button(loadTestData) {
                        tracker.refuels = Refuel.data
                        tracker.otherCosts = OtherCost.data
                        tracker.save()
                    }
                }
            }
            .accentColor(.red)
            .navigationBarTitle(viewTitle, displayMode: .inline)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(tracker: MileageTracker())
    }
}
