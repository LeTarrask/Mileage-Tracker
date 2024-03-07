//
//  Strings.swift
// Fuel Logue
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
let refuelAtString = NSLocalizedString("Refuel: ", comment: "")
let sinceLast = NSLocalizedString("Since last refuel", comment: "")
let totalLabel = NSLocalizedString("Total", comment: "")

// AddObjectView
let addNewCost = NSLocalizedString("Add new cost", comment: "")
let typeOfCost = NSLocalizedString("Type of Cost", comment: "")

/// AddRefuelView
let addInfoLabel = NSLocalizedString("Add refuel info", comment: "")
let kmAddedLabel = NSLocalizedString("Kilometers added", comment: "")
let litersAddedLabel = NSLocalizedString("Liters added", comment: "")
let costLabel = NSLocalizedString("Refuel Cost:", comment: "")
let saveLabel = NSLocalizedString("Save", comment: "")
let added = NSLocalizedString("Added ", comment: "")

/// AddCostView
let addCost = NSLocalizedString("Add Vehicle Cost", comment: "")
let costName = NSLocalizedString("Cost Name:", comment: "")
let costType = NSLocalizedString("Cost type:", comment: "")
let costValue = NSLocalizedString("Cost Value:", comment: "")

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
let kmPerEuro = NSLocalizedString("KM/€", comment: "")
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
let appLink = URL(string: "https://apps.apple.com/us/app/fuel-logue/id1670711112")!
let feedback = NSLocalizedString("Feedback", comment: "")
let rateUs = NSLocalizedString("Rate us on the App Store", comment: "")
let rateLink = URL(string: "https://apps.apple.com/us/app/fuel-logue/id1670711112")!
let survey = NSLocalizedString("Take a survey", comment: "")
let surveyLink = URL(string: "https://www.tarrask.com")!
let talkToUs = NSLocalizedString("Talk to the developer", comment: "")
let resetApp = NSLocalizedString("Reset app", comment: "")
let deleteData = NSLocalizedString("Delete all app data", comment: "")
let testData = NSLocalizedString("Test data", comment: "")
let loadTestData = NSLocalizedString("Load test data", comment: "")
let cannotSendEmail = NSLocalizedString("Cannot send email", comment: "")
let measurementUnityTitle = NSLocalizedString("Choose Measurement Unit", comment: "")
let measurementUnity = NSLocalizedString("Measurement Unit", comment: "")
let currencyLabel = NSLocalizedString("Currency", comment: "")

/// Onboarding
let nextLabel = NSLocalizedString("Next", comment: "")
let dismissLabel = NSLocalizedString("Dismiss", comment: "")
let onboardingHealine1 = NSLocalizedString("Welcome to Fuellogue", comment: "")
let onboardingCopy1 = NSLocalizedString("Monitor your motorbike's fuel costs, payments, and mileage all in one place. \n\nView your information on a sleek SwiftUI chart that updates in real-time as you add new data.", comment: "")
let creditText1: LocalizedStringKey = "Photo: [Gijs Coolen](https://unsplash.com/@gijsparadijs?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText) from [Unsplash](https://unsplash.com/pt-br/fotografias/v5tvgLFvX70?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)"
let onboardingHealine2 = NSLocalizedString("Understand, store and export your data", comment: "")
let onboardingCopy2 = NSLocalizedString("Your data is securely stored on your device and can be easily exported to a spreadsheet. \n\nThe information you input is used to generate charts for different timeframes, allowing you to see how your bike expenses and mileage are trending. With our user-friendly interface, it's simple to understand whether you're spending more or less than the average.", comment: "")
let creditText2: LocalizedStringKey = "Photo: [Summer Chan](https://unsplash.com/@chansummerla?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText) from [Unsplash](https://unsplash.com/pt-br/fotografias/nvxxjqAfWKo?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)"
let onboardingHealine3 = NSLocalizedString("New features coming", comment: "")
let onboardingCopy3 = NSLocalizedString("Fuellogue is a hobby project and completely free to use. While we plan to introduce premium features in the future, your basic account will always be free. \n\nWe welcome suggestions for new features that you would like to see, and we encourage you to check out our roadmap to see what we have planned.", comment: "")
let creditText3: LocalizedStringKey = "Photo: [Gijs Coolen](https://unsplash.com/@gijsparadijs?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText) from [Unsplash](https://unsplash.com/pt-br/fotografias/v5tvgLFvX70?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)"

// Loading
let loadCostsHeadline = NSLocalizedString("Add your bike costs info", comment: "")
let loadCostsParagraph = NSLocalizedString("Fill our tank with your bike costs info and we'll create charts detailing how your bike's performing", comment: "")
let loadRefuelsHeadline = NSLocalizedString("Add your refuel info", comment: "")
let loadRefuelParagraph = NSLocalizedString("Fill our tank with your refuel info and we'll create charts detailing how your bike's performing", comment: "")

// swiftlint:enable line_length
