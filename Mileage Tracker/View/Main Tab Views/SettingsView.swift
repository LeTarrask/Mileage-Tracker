//
//  SettingsView.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 18/01/2021.
//

import MessageUI
import SwiftUI

struct SettingsView: View {
    @StateObject var themeMG: ThemeManager = ThemeManager.shared

    @State var chosenTheme: Theme = .theme1

    @ObservedObject var tracker: MileageTracker

    @Environment(\.openURL) var openURL

    @State var canExport = true // this property controls if user has bought export func
    @State private var showShareSheet = false

    // swiftlint:disable redundant_optional_initialization
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    @State var alertNoMail = false

    var body: some View {
        Form {
            Section(header: Text(buyTitle)) {
                Button(removeAds) {
                    openURL(inAppURL)
                }
                Button(exportData) {
                    if canExport {
                        showShareSheet = true
                    } else {
                        // here should call for in app purchase
                        // https://blckbirds.com/post/how-to-use-in-app-purchases-in-swiftui-apps/
                        openURL(exportURL)
                    }
                }
            }

            Section(header: Text(chooseTheme)) {
                EnumPicker(selection: $chosenTheme, label: Text(chooseTheme.description))
            }.onChange(of: chosenTheme, perform: { value in
                ThemeManager.shared.applyTheme(theme: value)
                print("New theme chosen: " + value.description)
            })

            Section(header: Text(shareTracker)) {
                Button(copyAppLink) { openURL(appLink) }
            }

            Section(header: Text(feedback)) {
                Button(rateUs) { openURL(rateLink) }
                Button(survey) { openURL(surveyLink) }
                Button(talkToUs) {
                    MFMailComposeViewController.canSendMail() ? isShowingMailView.toggle() : alertNoMail.toggle()
                }
            }

            Section(header: Text(resetApp)) {
                Button(deleteData) {
                    tracker.deleteData()
                }
            }
            // Comment this section to publish app
            Section(header: Text(testData)) {
                Button(loadTestData) {
                    tracker.loadTestData()
                }
            }
        }
        .foregroundColor(themeMG.theme.mainColor)
        .sheet(isPresented: $isShowingMailView) {
            MailView(isShowing: $isShowingMailView, result: $result)
        }
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(activityItems: [tracker.csvFile()])
        }
        .alert(isPresented: $alertNoMail) {
            Alert(title: Text("Cannot send email"))
        }
    }

    /// VIEW STRINGS & URLs
    private let buyTitle = NSLocalizedString("In-App Purchases", comment: "")
    private let removeAds = NSLocalizedString("Remove ads", comment: "")
    private let inAppURL = URL(string: "https://www.tarrask.com")!
    private let chooseTheme = NSLocalizedString("Choose theme", comment: "")
    private let exportData = NSLocalizedString("Export data", comment: "")
    private let exportURL = URL(string: "https://www.tarrask.com")!
    private let viewTitle = NSLocalizedString("App Settings", comment: "")
    private let shareTracker = NSLocalizedString("Share Mileage Tracker", comment: "")
    private let copyAppLink = NSLocalizedString("Copy App Link", comment: "")
    private let appLink = URL(string: "https://www.tarrask.com")!
    private let feedback = NSLocalizedString("Feedback", comment: "")
    private let rateUs = NSLocalizedString("Rate us on the App Store", comment: "")
    private let rateLink = URL(string: "https://www.tarrask.com")!
    private let survey = NSLocalizedString("Take a survey", comment: "")
    private let surveyLink = URL(string: "https://www.tarrask.com")!
    private let talkToUs = NSLocalizedString("Talk to the developer", comment: "")
    private let resetApp = NSLocalizedString("Reset app", comment: "")
    private let deleteData = NSLocalizedString("Delete all app data", comment: "")
    private let testData = NSLocalizedString("Test data", comment: "")
    private let loadTestData = NSLocalizedString("Load test data", comment: "")


}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(tracker: MileageTracker())
    }
}
