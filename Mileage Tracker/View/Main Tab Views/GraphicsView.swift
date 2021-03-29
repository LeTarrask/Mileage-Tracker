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

    @State var showAdvertising = false

    @State var graphType: GraphType = .spending

    var body: some View {
        VStack {
            if showAdvertising && !tracker.paidApp {
                InterstitialView()
            } else {
                // MARK: - Regular Screen
                VStack {
                    GeometryReader { reader in
                        VStack {
                            // MARK: - Averages display
                            ZStack {
                                BackgroundCard()
                                    .frame(maxHeight: 140)
                                VStack(alignment: .center) {
                                    Text("Total KM: " + String(tracker.totalKM.clean) + " km")
                                        .foregroundColor(themeMG.theme.highlightColor)
                                        .font(.title)
                                        .fontWeight(.bold)
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Square(icon: nil,
                                                   number: tracker.averageConsumption,
                                                   value: "km/L",
                                                   label: "Average consumption")
                                            Square(icon: nil,
                                                   number: tracker.averageSpending,
                                                   value: "km/€",
                                                   label: "Average spending")
                                        }
                                        Spacer()
                                        VStack {
                                            Square(icon: nil,
                                                   number: tracker.totalSpending,
                                                   value: "€",
                                                   label: "Total fuel spending")
                                            Square(icon: nil,
                                                   number: tracker.averagePrice,
                                                   value: "€/l",
                                                   label: "Average Fuel Price")
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
                                        Text("Refuel Cost")
                                    })
                                    Spacer()
                                    Button(action: {graphType = .dates}, label: {
                                        Text("Price per liter")
                                    })
                                    Spacer()
                                    Button(action: {graphType = .km}, label: {
                                        Text("Kms per refuel")
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
                showAdvertising = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    showAdvertising = false
                }
            }
        })
    }
}

struct GraphicsView_Previews: PreviewProvider {
    static var previews: some View {
        let view = GraphicsView(tracker: MileageTracker())
        view.tracker.refuels = Refuel.data
        view.tracker.paidApp = false
        return view
    }
}
