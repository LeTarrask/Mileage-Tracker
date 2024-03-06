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
    @EnvironmentObject var tracker: MileageTracker
    @EnvironmentObject var settingsMG: SettingsManager

    @State var showInterstitial = false

    @State var graphType: GraphType = .spending
    @State var timeframe: FilterType = .none

    var body: some View {
        // MARK: - Regular Screen
        VStack {
            if tracker.refuels.isEmpty {
                LoadingView(headline: loadRefuelsHeadline, paragraph: loadRefuelParagraph, image: "fuelpump")
            } else {
                VStack(alignment: .center) {
                    AveragesBoard()

                    VStack {
                        timeframeSelector()

                        graphicSelector()
                    }
                    .padding(.vertical, 20)
                    .fixedSize(horizontal: false, vertical: true)
                    .background {
                        settingsMG.theme.backgroundColor
                            .cornerRadius(25)
                    }
                    .padding(20)

                    graphicDisplay()
                }
            }
        }
        .background(settingsMG.theme.secondColor)
    }

    // MARK: - Averages display
    @ViewBuilder
    func timeframeSelector() -> some View {
        // MARK: - Timeframe selector
        Picker(timeframeString, selection: $timeframe) {
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
        Picker(graphicString, selection: $graphType) {
            Text(refuelString).tag(GraphType.spending)
            Text("Price/"+settingsMG.chosenVolume).tag(GraphType.dates)
            Text(settingsMG.chosenDistance+"/"+settingsMG.chosenCurrency).tag(GraphType.km)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal, 20)
    }

    @ViewBuilder
    func graphicDisplay() -> some View {
        // MARK: - Graphic
        ZStack {
            settingsMG.theme.backgroundColor
                .cornerRadius(25)

            Chart(filterBy(timeframe), id: \.id) { refuel in
                switch graphType {
                case .spending:
                    BarMark(x: .value(dateLocalizedString, refuel.creationDate),
                            y: .value(refuelString, refuel.money)
                    )
                    .accessibilityValue(refuel.money.clean)
                    .foregroundStyle(settingsMG.theme.mainColor)
                case .dates:
                    PointMark(x: .value(dateLocalizedString, refuel.creationDate),
                              y: .value(priceString, refuel.pricePerLiter)
                    )
                    .foregroundStyle(settingsMG.theme.mainColor)
                case .km:
                    LineMark(x: .value(dateLocalizedString, refuel.creationDate),
                             y: .value(averageSpenValue, refuel.kmAdded/refuel.money)
                    )
                    .foregroundStyle(settingsMG.theme.mainColor)
                    .lineStyle(StrokeStyle(lineWidth: 2.0))
                    .interpolationMethod(.catmullRom)
                    .symbol(Circle().strokeBorder(lineWidth: 2.0))
                    .symbolSize(60)
                    
                }
            }
            .padding([.horizontal, .top], 20)
        }.padding()
    }

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
        GraphicsView()
            .environmentObject(MileageTracker.shared)
            .environmentObject(SettingsManager.shared)

        GraphicsView()
            .environmentObject(MileageTracker.shared)
            .environmentObject(SettingsManager.shared)
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            .previewDisplayName("iPhone SE (3rd generation)")
    }
}
