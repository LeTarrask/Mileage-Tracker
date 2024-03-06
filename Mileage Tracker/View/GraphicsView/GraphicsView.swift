//
//  GraphicsView.swift
// Fuel Logue
//
//  Created by Alex Luna on 14/01/2021.
//

import SwiftUI

enum GraphType {
    // swiftlint:disable identifier_name
    case spending, dates, km
    // swiftlint:enable identifier_name
}

enum FilterType {
    case none, month, year
}

struct GraphicsView: View {
    @EnvironmentObject var mileageVM: MileageViewModel
    @EnvironmentObject var settingsMG: SettingsManager

    @State var showInterstitial = false

    @State var graphType: GraphType = .spending
    @State var timeframe: FilterType = .none

    var body: some View {
        // MARK: - Regular Screen
        VStack {
            if mileageVM.refuels.isEmpty {
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

    func filterBy(_ type: FilterType) -> [Refuel] {
        switch timeframe {
        case .month:
            return mileageVM.refuels.filter({ $0.creationDate > addOrSubtractMonth(month: -1)})
        case .year:
            return mileageVM.refuels.filter({ $0.creationDate > addOrSubtractYear(year: -1)})
        case .none:
            return mileageVM.refuels
        }
    }
}

struct GraphicsView_Previews: PreviewProvider {
    static var previews: some View {
        GraphicsView()
            .environmentObject(MileageViewModel.shared)
            .environmentObject(SettingsManager.shared)

        GraphicsView()
            .environmentObject(MileageViewModel.shared)
            .environmentObject(SettingsManager.shared)
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            .previewDisplayName("iPhone SE (3rd generation)")
    }
}
