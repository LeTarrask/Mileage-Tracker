//
//  GraphicsView.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 14/01/2021.
//

import SwiftUI

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
    let mainTitleString = NSLocalizedString("Total:", comment: "")
    let distanceValueString = NSLocalizedString("km", comment: "")
    let averageConsLabel = NSLocalizedString("Average consumption", comment: "")
    let averageConsValue = NSLocalizedString("km/L", comment: "")
    let averageSpenLabel = NSLocalizedString("Average spending", comment: "")
    let averageSpenValue = NSLocalizedString("km/€", comment: "")
    let moneySymbol = NSLocalizedString("€", comment: "")
    let totalFuelSpendingLabel = NSLocalizedString("Total fuel spending", comment: "")
    let averageFuelPriceLabel = NSLocalizedString("Average Fuel Price", comment: "")
    let averageFuelPriceValue = NSLocalizedString("€/l", comment: "")

    let refuelString = NSLocalizedString("Refuel cost", comment: "")
    let priceString = NSLocalizedString("Price/liter", comment: "")
    let kmRefuelString = NSLocalizedString("Km/refuel", comment: "")

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
                            ZStack {
                                RoundedRectangle(cornerRadius: 7)
                                    .fill(themeMG.theme.backgroundColor)
                                    .frame(maxHeight: 30)
                                    .shadow(color: .black, radius: 1, x: 1, y: 1)
                                HStack {
                                    Button(action: {graphType = .spending}, label: {
                                        Text(refuelString)
                                    })
                                    Spacer()
                                    Button(action: {graphType = .dates}, label: {
                                        Text(priceString)
                                    })
                                    Spacer()
                                    Button(action: {graphType = .km}, label: {
                                        Text(kmRefuelString)
                                    })
                                }
                                .foregroundColor(themeMG.theme.secondaryColor)
                                .padding()
                            }.padding()
                            .frame(width: .infinity, height: reader.size.width * 0.1)
                            // MARK: - Graphic
                            Graphic(tracker: tracker, type: $graphType)
                                .padding()
                                .frame(width: .infinity, height: reader.size.width * 0.55)
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
