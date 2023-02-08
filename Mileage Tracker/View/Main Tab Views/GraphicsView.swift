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

enum FilterType {
    case none, month, year
}

struct GraphicsView: View {
    @StateObject var themeMG: ThemeManager = ThemeManager.shared

    @ObservedObject var tracker: MileageTracker

    @State var showInterstitial = false

    @State var graphType: GraphType = .spending
    @State var timeframe: FilterType = .none

    var body: some View {
        VStack {
            if showInterstitial && !tracker.paidApp {
//                InterstitialView()
            } else {
                // MARK: - Regular Screen
                VStack {
                    VStack(alignment: .center) {
                        averagesBoard()

                        timeframeSelector()

                        graphicSelector()

                        graphicGenerator()
                    }
                }
                // MARK: - Ad Banner
//                if !tracker.paidApp { Banner() }
            }
        }
        .edgesIgnoringSafeArea(.all)
        // MARK: Paid app interstitial presenter
        .onAppear(perform: {
            if !tracker.paidApp {
                showInterstitial = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    showInterstitial = false
                }
            }
        })
    }

    // swiftlint:disable function_body_length
    // MARK: - Averages display
    @ViewBuilder
    func averagesBoard() -> some View {
        ZStack {
            themeMG.theme.backgroundColor
                .cornerRadius(25)

            VStack(alignment: .leading) {
                Text(totalString)
                    .fontWeight(.black)
                    .foregroundColor(themeMG.theme.mainColor)

                HStack {
                    VStack(alignment: .leading) {
                        Text(tracker.averageConsumption.clean + " " + averageConsValue)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(themeMG.theme.mainColor)
                        Text(averageConsLabel)
                            .font(.caption2)
                            .foregroundColor(themeMG.theme.subtitleTextColor)
                    }

                    VStack(alignment: .leading) {
                        Text(tracker.totalSpending.clean + " " + moneySymbol)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(themeMG.theme.mainColor)
                        Text(totalFuelSpendingLabel)
                            .font(.caption2)
                            .foregroundColor(themeMG.theme.subtitleTextColor)
                    }
                }

                HStack {
                    VStack(alignment: .leading) {
                        Text(tracker.averageSpending.clean + " " + averageSpenValue)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(themeMG.theme.mainColor)
                        Text(averageSpenLabel)
                            .font(.caption2)
                            .foregroundColor(themeMG.theme.subtitleTextColor)
                    }

                    VStack(alignment: .leading) {
                        Text(String(tracker.averagePrice) + " " + averageFuelPriceValue)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(themeMG.theme.mainColor)
                        Text(averageFuelPriceLabel)
                            .font(.caption2)
                            .foregroundColor(themeMG.theme.subtitleTextColor)
                    }
                }
            }
        }
        .padding()
    }

    @ViewBuilder
    func timeframeSelector() -> some View {
        // MARK: - Timeframe selector
        Picker("Timeframe", selection: $timeframe) {
            Text(lastMonthString).tag(FilterType.month)
            Text(lastYearString).tag(FilterType.year)
            Text(allTimeString).tag(FilterType.none)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal, 20)
    }

    @ViewBuilder
    func graphicSelector() -> some View {
        // MARK: - Graphics Selector
        Picker("Graphic", selection: $graphType) {
            Text(refuelString).tag(GraphType.spending)
            Text(priceString).tag(GraphType.dates)
            Text(kmRefuelString).tag(GraphType.km)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal, 20)
    }

    @ViewBuilder
    func graphicGenerator() -> some View {
        // MARK: - Graphic
        ZStack {
            themeMG.theme.backgroundColor
                .cornerRadius(25)

            Chart(filterBy(timeframe), id: \.id) { refuel in
                switch graphType {
                case .spending:
                    BarMark(x: .value(dateLocalizedString, refuel.creationDate),
                            y: .value(refuelString, refuel.money)
                    )
                    .accessibilityValue(refuel.money.clean)
                    .foregroundStyle(themeMG.theme.mainColor)
                case .dates:
                    PointMark(x: .value(dateLocalizedString, refuel.creationDate),
                              y: .value(priceString, refuel.pricePerLiter)
                    )
                    .foregroundStyle(themeMG.theme.mainColor)
                case .km:
                    LineMark(x: .value(dateLocalizedString, refuel.creationDate),
                             y: .value(averageSpenValue, refuel.kmAdded/refuel.money)
                    )
                    .foregroundStyle(themeMG.theme.mainColor)
                    .lineStyle(StrokeStyle(lineWidth: 2.0))
                    .interpolationMethod(.catmullRom)
                    .symbol(Circle().strokeBorder(lineWidth: 2.0))
                    .symbolSize(60)
                }
            }
        }.padding()
    }

    /// VIEW STRINGS & URLs
    private let totalString = NSLocalizedString("Total:", comment: "")
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
    private let dateLocalizedString = NSLocalizedString("Date", comment: "")
    private let lastMonthString = NSLocalizedString("Last month", comment: "")
    private let lastYearString = NSLocalizedString("Last year", comment: "")
    private let allTimeString = NSLocalizedString("All time", comment: "")

    func filterBy(_ type: FilterType) -> [Refuel] {
        switch timeframe {
        case .month:
            return tracker.refuels.filter({ $0.creationDate > addOrSubtractMonth(month: -1)})
        case .year:
            return tracker.refuels.filter({ $0.creationDate > addOrSubtractYear(year: -1)})
        case .none:
            return tracker.refuels
        }
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
