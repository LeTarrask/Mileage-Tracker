//
//  Strings.swift
//  Mileage Tracker
//
//  Created by tarrask on 08/02/2023.
//

import Foundation
import SwiftUI

// swiftlint:disable line_length
/// MainAppView
let refuelsString = NSLocalizedString("Refuels", comment: "")
let otherCostsString = NSLocalizedString("Other costs", comment: "")
let statsString = NSLocalizedString("Stats", comment: "")
let settingsString = NSLocalizedString("Settings", comment: "")
let addCostString = NSLocalizedString("Add Cost", comment: "")

/// RefuelCardView
let refuelAtString = NSLocalizedString("Refuel at: ", comment: "")
let sinceLast = NSLocalizedString("Since last", comment: "")
let kmLabel = NSLocalizedString("km", comment: "")
let literLabel = NSLocalizedString("L", comment: "")
let fuelLabel = NSLocalizedString("Fuel", comment: "")
let euroLabel = NSLocalizedString("€", comment: "")
let paymentLabel = NSLocalizedString("Payment", comment: "")
let thanAverageLabel = NSLocalizedString("than average:", comment: "")
let perLiter = NSLocalizedString("per liter:", comment: "")
let totalLabel = NSLocalizedString("Total", comment: "")
let refuelAtLabel = NSLocalizedString("Refuel at: ", comment: "")

/// AddRefuelView
let addInfoLabel = NSLocalizedString("Add refuel info", comment: "")
let kmAddedLabel = NSLocalizedString("Kilometers added", comment: "")
let litersAddedLabel = NSLocalizedString("Liters added", comment: "")
let costLabel = NSLocalizedString("Refuel Cost", comment: "")
let saveLabel = NSLocalizedString("Save", comment: "")

/// AddCostView
let addCost = NSLocalizedString("Add Vehicle Cost", comment: "")
let costName = NSLocalizedString("Cost Name", comment: "")
let costType = NSLocalizedString("Cost type", comment: "")
let costValue = NSLocalizedString("Cost Value", comment: "")

/// GraphicsView
let totalString = NSLocalizedString("Total:", comment: "")
let distanceValueString = NSLocalizedString("km", comment: "")
let averageConsLabel = NSLocalizedString("Average consumption", comment: "")
let averageConsValue = NSLocalizedString("km/L", comment: "")
let averageSpenLabel = NSLocalizedString("Average spending", comment: "")
let averageSpenValue = NSLocalizedString("km/€", comment: "")
let moneySymbol = NSLocalizedString("€", comment: "")
let totalFuelSpendingLabel = NSLocalizedString("Total fuel spending", comment: "")
let averageFuelPriceLabel = NSLocalizedString("Average Fuel Price", comment: "")
let averageFuelPriceValue = NSLocalizedString("€/L", comment: "")
let refuelString = NSLocalizedString("Refuel cost", comment: "")
let priceString = NSLocalizedString("Price/liter", comment: "")
let kmRefuelString = NSLocalizedString("Km/refuel", comment: "")
let dateLocalizedString = NSLocalizedString("Date", comment: "")
let lastMonthString = NSLocalizedString("Last month", comment: "")
let lastYearString = NSLocalizedString("Last year", comment: "")
let allTimeString = NSLocalizedString("All time", comment: "")
let timeframeString = NSLocalizedString("Timeframe", comment: "")
let graphicString = NSLocalizedString("Graphic", comment: "")

/// OtherCostsView
let totalOtherLabel = NSLocalizedString("Total Other Costs: ", comment: "")
let valueLabel = NSLocalizedString("€", comment: "")

/// SettingsView
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
let cannotSendEmail = NSLocalizedString("Cannot send email", comment: "")

/// Onboarding
let nextLabel = NSLocalizedString("Next", comment: "")
let dismissLabel = NSLocalizedString("Dismiss", comment: "")
let onboardingHealine1 = NSLocalizedString("Welcome to Fuellogue", comment: "")
let onboardingCopy1 = NSLocalizedString("Track your bike fuel expenses, other payments and vehicle mileage. See the data in a fancy SwiftUI Chart.", comment: "")
let creditText1: LocalizedStringKey = "Photo: [Gijs Coolen](https://unsplash.com/@gijsparadijs?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText) from [Unsplash](https://unsplash.com/pt-br/fotografias/v5tvgLFvX70?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)"
let onboardingHealine2 = NSLocalizedString("Store and export your data", comment: "")
let onboardingCopy2 = NSLocalizedString("All data is just stored on your device. It also can be exported to a spreadsheet.", comment: "")
let creditText2: LocalizedStringKey = "Photo: [Summer Chan](https://unsplash.com/@chansummerla?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText) from [Unsplash](https://unsplash.com/pt-br/fotografias/nvxxjqAfWKo?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)"
let onboardingHealine3 = NSLocalizedString("Get extra features", comment: "")
let onboardingCopy3 = NSLocalizedString("Fuellogue will always be free. We plan to add premium features in the future. Check the roadmap.", comment: "")
let creditText3: LocalizedStringKey = "Photo: [Gijs Coolen](https://unsplash.com/@gijsparadijs?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText) from [Unsplash](https://unsplash.com/pt-br/fotografias/v5tvgLFvX70?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)"  

// Loading
let loadCostsHeadline = NSLocalizedString("Add your bike costs info", comment: "")
let loadCostsParagraph = NSLocalizedString("Fill our tank with your bike costs info and we'll create charts detailing how your bike's performing", comment: "")
let loadRefuelsHeadline = NSLocalizedString("Add your refuel info", comment: "")
let loadRefuelParagraph = NSLocalizedString("Fill our tank with your refuel info and we'll create charts detailing how your bike's performing", comment: "")
