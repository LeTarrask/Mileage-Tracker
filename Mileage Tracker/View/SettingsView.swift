//
//  SettingsView.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 18/01/2021.
//

import MessageUI
import SwiftUI

struct SettingsView: View {
    var theme: Theme = ThemeManager.currentTheme()
    @State var chosenTheme: Theme = .theme1

    @ObservedObject var tracker: MileageTracker

    @Environment(\.openURL) var openURL

    @State var canExport = true // this property controls if user has bought export func
    @State private var showShareSheet = false

    // swiftlint:disable redundant_optional_initialization
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    @State var alertNoMail = false

    /// VIEW STRINGS & URLs
    let buyTitle = NSLocalizedString("In-App Purchases", comment: "")
    let removeAds = NSLocalizedString("Remove ads", comment: "")
    let inAppURL = URL(string: "https://www.tarrask.com")!
    let chooseTheme = NSLocalizedString("Choose theme", comment: "")
    let exportData = NSLocalizedString("Export data", comment: "")
    let exportURL = URL(string: "https://www.tarrask.com")!
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
    let resetApp = NSLocalizedString("Reset app", comment: "")
    let deleteData = NSLocalizedString("Delete all app data", comment: "")
    let testData = NSLocalizedString("Test data", comment: "")
    let loadTestData = NSLocalizedString("Load test data", comment: "")

    var body: some View {
        NavigationView {
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
                            openURL(exportURL)
                        }
                    }
                }

                Section(header: Text(chooseTheme)) {
                    EnumPicker(selection: $chosenTheme, label: Text(chooseTheme.description))
                }.onChange(of: chosenTheme, perform: { value in
                    ThemeManager.applyTheme(theme: value)
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
            .foregroundColor(theme.mainColor)
            .navigationBarTitle(viewTitle, displayMode: .inline)
        }
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
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(tracker: MileageTracker())
    }
}
