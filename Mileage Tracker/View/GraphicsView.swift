//
//  GraphicsView.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 14/01/2021.
//

import SwiftUI
import SwiftUICharts // https://github.com/AppPear/ChartView

struct GraphicsView: View {
    @State var isLoading = true
    @ObservedObject var tracker: MileageTracker
    @State var graphType: GraphType = .spending

    var body: some View {
        NavigationView {
            VStack {
                if isLoading && !tracker.paidApp {
                    InterstitialView()
                } else {
                    // MARK: - Regular Screen
                    ScrollView {
                        VStack {
                            // MARK: - Averages display
                            ZStack {
                                BackgroundCard()
                                    .frame(maxHeight: 140)
                                VStack(alignment: .center) {
                                    Text("Total KM: " + String(tracker.totalKM.clean) + " km")
                                        .foregroundColor(Color("Yellowish"))
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
                            }.padding()
                            // MARK: - Graphics Selector
                            ZStack {
                                RoundedRectangle(cornerRadius: 7)
                                    .fill(Color("Cream"))
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
                                .foregroundColor(Color("Wine"))
                                .padding()
                            }.padding()
                            // MARK: - Graphic
                            Graphic(tracker: tracker, type: $graphType)
                                .padding()
                        }
                        // MARK: - Ad Banner
                        Banner()
                    }.navigationBarTitle("Vehicle Stats", displayMode: .inline)
                }
            }
            .onAppear(perform: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    isLoading = false
                }
            }
            )
        }
    }
}

enum GraphType {
    // swiftlint:disable identifier_name
    case spending, dates, km
}

struct Graphic: View {
    @ObservedObject var tracker: MileageTracker
    @Binding var type: GraphType

    var body: some View {
        let chartStyle = ChartStyle(backgroundColor: Color("Cream"),
                                    accentColor: Color("Wine"),
                                    gradientColor: GradientColor(start:
                                                                    Color("Yellowish"),
                                                                 end: Color("Wine")),
                                    textColor: Color("Wine"),
                                    legendTextColor: Color("Redder"),
                                    dropShadowColor: .gray)

        switch type {
        case .spending:
            LineView(data: tracker.refuels.map { $0.money },
                     title: "Refuel cost", style: chartStyle)

        case .dates:
            LineView(data: tracker.refuels.map {
                        Double($0.pricePerLiter) },
                     title: "Price per liter", style: chartStyle)
        case .km:
            LineView(data: tracker.refuels.map { $0.kmAdded }, title: "KM per Refuel", style: chartStyle)
        }
    }
}

struct BackgroundCard: View {
    var body: some View {
        LinearGradient(gradient:
                        Gradient(colors: [Color("Redder"), Color("Wine")]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
            .cornerRadius(15)
            .shadow(color: .black, radius: 3, x: 2, y: 1)
    }
}

struct GraphicsView_Previews: PreviewProvider {
    static var previews: some View {
        let view = GraphicsView(tracker: MileageTracker())
        view.tracker.refuels = Refuel.data
        return view
    }
}
