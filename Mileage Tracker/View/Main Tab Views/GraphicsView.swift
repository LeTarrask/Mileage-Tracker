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
                                themeMG.theme.backgroundColor
                                    .cornerRadius(25)

                                VStack(alignment: .leading) {
                                    Text("Total:")
                                        .fontWeight(.black)
                                        .foregroundColor(themeMG.theme.secondaryColor)

                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(String(tracker.averageConsumption) + " " + averageConsValue)
                                                .font(.title3)
                                                .fontWeight(.bold)
                                                .foregroundColor(themeMG.theme.secondaryColor)
                                            Text(averageConsLabel)
                                                .font(.caption2)
                                                .foregroundColor(themeMG.theme.subtitleTextColor)
                                        }

                                        VStack(alignment: .leading) {
                                            Text(String(tracker.totalSpending) + " " + moneySymbol)
                                                .font(.title3)
                                                .fontWeight(.bold)
                                                .foregroundColor(themeMG.theme.secondaryColor)
                                            Text(totalFuelSpendingLabel)
                                                .font(.caption2)
                                                .foregroundColor(themeMG.theme.subtitleTextColor)
                                        }
                                    }

                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(String(tracker.averageSpending) + " " + averageSpenValue)
                                                .font(.title3)
                                                .fontWeight(.bold)
                                                .foregroundColor(themeMG.theme.secondaryColor)
                                            Text(averageSpenLabel)
                                                .font(.caption2)
                                                .foregroundColor(themeMG.theme.subtitleTextColor)
                                        }

                                        VStack(alignment: .leading) {
                                            Text(String(tracker.averagePrice) + " " + averageFuelPriceValue)
                                                .font(.title3)
                                                .fontWeight(.bold)
                                                .foregroundColor(themeMG.theme.secondaryColor)
                                            Text(averageFuelPriceLabel)
                                                .font(.caption2)
                                                .foregroundColor(themeMG.theme.subtitleTextColor)
                                        }
                                    }
                                }
                            }
                            .padding()
                            .frame(width: .infinity, height: reader.size.height * 0.25)

                            // MARK: - Graphics Selector
                            Picker("Graphic", selection: $graphType.animation(.easeInOut)) {
                                Text(refuelString).tag(GraphType.spending)
                                Text(priceString).tag(GraphType.dates)
                                Text(kmRefuelString).tag(GraphType.km)
                            }
                            .foregroundColor(themeMG.theme.mainColor)

                            // MARK: - Graphic
                            ZStack {
                                themeMG.theme.backgroundColor
                                    .cornerRadius(25)

                                switch graphType {
                                case .spending:
                                    Chart(tracker.refuels) { refuel in
                                        BarMark(x: .value("Date", refuel.creationDate),
                                                y: .value("Refuel Cost", refuel.money)
                                        )
                                        .foregroundStyle(themeMG.theme.mainColor)
                                    }.padding(30)
                                case .dates:
                                    Chart(tracker.refuels) { refuel in
                                        PointMark(x: .value("Date", refuel.creationDate),
                                                y: .value("Price/liter", refuel.pricePerLiter)
                                        )
                                        .foregroundStyle(themeMG.theme.mainColor)
                                    }.padding(30)
                                case .km:
                                    Chart(tracker.refuels) { refuel in
                                        LineMark(x: .value("Date", refuel.creationDate),
                                                 y: .value("KM / money", refuel.kmAdded/refuel.money)
                                        )
                                        .foregroundStyle(themeMG.theme.mainColor)
                                        .lineStyle(StrokeStyle(lineWidth: 2.0))
                                        .interpolationMethod(.cardinal)
                                        .symbol(Circle().strokeBorder(lineWidth: 2.0))
                                        .symbolSize(60)
                                    }.padding(30)
                                }
                            }.padding()
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
