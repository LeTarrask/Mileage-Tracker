//
//  SettingsView.swift
// Fuel Logue
//
//  Created by Alex Luna on 18/01/2021.
//

import MessageUI
import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var tracker: MileageViewModel
    @EnvironmentObject var settingsMG: SettingsManager

    @State var chosenTheme: Theme = .theme1
    @State var selectedMeasure: MeasureUnits = .metric
    
    @AppStorage("ChosenDistance") var chosenDistance: String = "km"
    @AppStorage("ChosenVolume") var chosenVolume: String = "l"
    @AppStorage("Currency") var chosenCurrency: String = "€"
    @AppStorage("MeasureUnit") var chosenMeasure: String = "metric"

    @Environment(\.openURL) var openURL

    @State var canExport = true // this property controls if user has bought export func
    @State private var showShareSheet = false

    // swiftlint:disable redundant_optional_initialization
    @State var result: Result<MFMailComposeResult, Error>? = nil
    // swiftlint:enable redundant_optional_initialization
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
                SettingsManager.shared.applyTheme(theme: value)
                print("New theme chosen: " + value.description)
            })
            .listRowBackground(chosenTheme.backgroundColor)
            
            Section(header: Text(measurementUnityTitle)) {
                Picker("\(measurementUnity): \(chosenDistance)/\(chosenVolume)", selection: $selectedMeasure) {
                    Text("Metric").tag(MeasureUnits.metric)
                    Text("Imperial").tag(MeasureUnits.imperial)
                }
                .onAppear {
                    if chosenMeasure == "imperial" {
                        selectedMeasure = .imperial
                    }
                }
                
                Picker("\(currencyLabel): \(chosenCurrency)", selection: $chosenCurrency) {
                    Text("€").tag("€")
                    Text("$").tag("$")
                }
            }
            .onChange(of: selectedMeasure, perform: { newValue in
                chosenDistance = newValue.distance
                chosenVolume = newValue.volume
                chosenMeasure = selectedMeasure.rawValue
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
// #if targetEnvironment(simulator)
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
// #endif
        }
        .onAppear {
            chosenTheme = settingsMG.theme
        }
        .foregroundColor(settingsMG.theme.mainColor)
        .background(settingsMG.theme.secondColor)
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
    SettingsView()
            .environmentObject(MileageViewModel.shared)
            .environmentObject(SettingsManager.shared)
    }
}
