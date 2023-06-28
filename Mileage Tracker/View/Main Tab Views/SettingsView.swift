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

    @StateObject var tracker = MileageTracker.shared

    @Environment(\.openURL) var openURL

    @State var canExport = true // this property controls if user has bought export func
    @State private var showShareSheet = false

    // swiftlint:disable redundant_optional_initialization
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    @State var alertNoMail = false

    var body: some View {
        Form {
//            Section(header: Text(buyTitle)) {
//               Button(removeAds) {
//                    openURL(inAppURL)
//                }
//            }

            Section(header: Text(chooseTheme)) {
                EnumPicker(selection: $chosenTheme, label: Text("Color Theme"))
            }
            
            .onChange(of: chosenTheme, perform: { value in
                ThemeManager.shared.applyTheme(theme: value)
                print("New theme chosen: " + value.description)
            })
            .listRowBackground(chosenTheme.backgroundColor)

            Section(header: Text(shareTracker)) {
                Button(copyAppLink) { openURL(appLink) }
            }
            .listRowBackground(chosenTheme.backgroundColor)

            Section(header: Text(feedback)) {
//                Button(rateUs) { openURL(rateLink) }
//                Button(survey) { openURL(surveyLink) }
                Button(talkToUs) {
                    MFMailComposeViewController.canSendMail() ? isShowingMailView.toggle() : alertNoMail.toggle()
                }
            }
            .listRowBackground(chosenTheme.backgroundColor)

            Section(header: Text(resetApp)) {
                Button(deleteData) {
                    tracker.deleteData()
                }
            }
            .listRowBackground(chosenTheme.backgroundColor)
            
            // Comment this section to publish app
//#if targetEnvironment(simulator)
            Section(header: Text(testData)) {
                Button(loadTestData) {
                    tracker.loadTestData()
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
            .listRowBackground(chosenTheme.backgroundColor)
//#endif
        }
        .onAppear {
            chosenTheme = themeMG.theme
        }
        .foregroundColor(themeMG.theme.mainColor)
        .background(themeMG.theme.secondaryColor)
        .scrollContentBackground(.hidden)
        .sheet(isPresented: $isShowingMailView) {
            MailView(isShowing: $isShowingMailView, result: $result)
        }
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(activityItems: [tracker.csvFile()])
        }
        .alert(isPresented: $alertNoMail) {
            Alert(title: Text(cannotSendEmail))
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(MileageTracker.shared)
    }
}
