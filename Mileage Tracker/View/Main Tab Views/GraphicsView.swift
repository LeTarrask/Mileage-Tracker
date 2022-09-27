//
//  GraphicsView.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 14/01/2021.
//

import SwiftUI
import Charts

enum GraphType {
    // swiftlint:disable identifier_name
    case spending, dates, km
}

struct GraphicsView: View {
    @StateObject var themeMG: ThemeManager = ThemeManager.shared
    
    @ObservedObject var tracker: MileageTracker
    
    @State var showInterstitial = false
    
    @State var graphType: GraphType = .spending
    
    /// VIEW STRINGS & URLs
    private let mainTitleString = NSLocalizedString("Total:", comment: "")
    private let distanceValueString = NSLocalizedString("km", comment: "")
    private let averageConsLabel = NSLocalizedString("Average consumption", comment: "")
    private let averageConsValue = NSLocalizedString("km/L", comment: "")
    private let averageSpenLabel = NSLocalizedString("Average spending", comment: "")
    private let averageSpenValue = NSLocalizedString("km/€", comment: "")
    private let moneySymbol = NSLocalizedString("€", comment: "")
    private let totalFuelSpendingLabel = NSLocalizedString("Total fuel spending", comment: "")
    private let averageFuelPriceLabel = NSLocalizedString("Average Fuel Price", comment: "")
    private let averageFuelPriceValue = NSLocalizedString("€/l", comment: "")
    private let refuelString = NSLocalizedString("Refuel cost", comment: "")
    private let priceString = NSLocalizedString("Price/liter", comment: "")
    private let kmRefuelString = NSLocalizedString("Km/refuel", comment: "")
    
    var body: some View {
        VStack {
            if showInterstitial && !tracker.paidApp {
                InterstitialView()
            } else {
                // MARK: - Regular Screen
                VStack {
                    GeometryReader { reader in
                        VStack(alignment: .center) {
                            // MARK: - Averages display
                            ZStack {
                                BackgroundCard()
                                VStack(alignment: .center) {
                                    HStack {
                                        Text(mainTitleString)
                                            .fontWeight(.bold)
                                        Text(" " + String(tracker.totalKM.clean) + " " )
                                        Text(distanceValueString)
                                            .fontWeight(.bold)
                                    }
                                    .foregroundColor(themeMG.theme.highlightColor)
                                    .font(.title)
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Square(icon: nil,
                                                   number: tracker.averageConsumption,
                                                   value: averageConsValue,
                                                   label: averageConsLabel)
                                            Square(icon: nil,
                                                   number: tracker.averageSpending,
                                                   value: averageSpenValue,
                                                   label: averageSpenLabel)
                                        }
                                        Spacer()
                                        VStack {
                                            Square(icon: nil,
                                                   number: tracker.totalSpending,
                                                   value: moneySymbol,
                                                   label: totalFuelSpendingLabel)
                                            Square(icon: nil,
                                                   number: tracker.averagePrice,
                                                   value: averageFuelPriceValue,
                                                   label: averageFuelPriceLabel)
                                        }
                                    }
                                }.padding()
                            }
                            .padding()
                            .frame(width: .infinity, height: reader.size.width * 0.40)
                            
                            // MARK: - Graphics Selector
                            Picker("Graphic", selection: $graphType.animation(.easeInOut)) {
                                Text(refuelString).tag(GraphType.spending)
                                Text(priceString).tag(GraphType.dates)
                                Text(kmRefuelString).tag(GraphType.km)
                            }
                            .pickerStyle(.segmented)
                            .animation(.easeInOut)
                            
                            // MARK: - Graphic
                            switch graphType {
                            case .spending:
                                Chart(tracker.refuels) { refuel in
                                    BarMark(x: .value("Date", refuel.creationDate),
                                            y: .value("Refuel Cost", refuel.money)
                                    )
                                }.padding(30)
                            case .dates:
                                Chart(tracker.refuels) { refuel in
                                    BarMark(x: .value("Date", refuel.creationDate),
                                            y: .value("Price/liter", refuel.pricePerLiter))
                                }.padding(30)
                            case .km:
                                Chart(tracker.refuels) { refuel in
                                    BarMark(x: .value("Date", refuel.creationDate),
                                            y: .value("KM after refuel", refuel.totalKM))
                                }.padding(30)
                            }
                        }
                    }
                    // MARK: - Ad Banner
                    if !tracker.paidApp {
                        Banner()
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear(perform: {
            if !tracker.paidApp {
                showInterstitial = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    showInterstitial = false
                }
            }
        })
    }
}

struct GraphicsView_Previews: PreviewProvider {
    static var previews: some View {
        let view = GraphicsView(tracker: MileageTracker())
        view.tracker.refuels = Refuel.data
        view.tracker.paidApp = true
        return view
    }
}
