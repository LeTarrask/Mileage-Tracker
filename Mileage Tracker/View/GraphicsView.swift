//
//  GraphicsView.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 14/01/2021.
//

import SwiftUI
import SwiftUICharts // https://github.com/AppPear/ChartView
// swiftlint:disable trailing_whitespace
struct GraphicsView: View {
    @ObservedObject var tracker: MileageTracker
    
    var graphs = ["spending", "dates", "km"]
    @State var graphType: GraphType = .spending
    
    var body: some View {
        NavigationView {
            VStack {
                // MARK: - Averages display
                ZStack {
                    BackgroundCard()
                        .frame(maxHeight: 140)
                    //                    VStack(alignment: .center) {
                    //                        Text("Total KM: " + String(tracker.totalKM.clean) + " km")
                    //                            .foregroundColor(Color("Yellowish"))
                    //                            .font(.title)
                    //                            .fontWeight(.bold)
                    //                        HStack {
                    //                            VStack(alignment: .leading) {
                    //                                Square(icon: nil,
                    //                                       number: tracker.averageConsumption,
                    //                                       value: "km/L",
                    //                                       label: "Average consumption")
                    //                                Square(icon: nil,
                    //                                       number: tracker.averageSpending,
                    //                                       value: "km/€",
                    //                                       label: "Average spending")
                    //                            }
                    //                            Spacer()
                    //                            VStack {
                    //                                Square(icon: nil,
                    //                                       number: tracker.totalSpending,
                    //                                       value: "€",
                    //                                       label: "Total fuel spending")
                    //                                Square(icon: nil,
                    //                                       number: tracker.averagePrice,
                    //                                       value: "€/l",
                    //                                       label: "Average Fuel Price")
                    //                            }
                    //                        }
                    //                    }.padding()
                }.padding()
                
                // MARK: - Graphics Selector
                ZStack {
                    RoundedRectangle(cornerRadius: 7)
                        .fill(Color("Cream"))
                        .frame(maxHeight: 30)
                    Picker("Text", selection: $graphType) {
                        ForEach(graphs, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    //                    HStack {
                    //                        Button(action: {graphType = .spending}, label: {
                    //                            Text("Spending")
                    //                        })
                    //                        Spacer()
                    //                        Button(action: {graphType = .dates}, label: {
                    //                            Text("Refuel Dates")
                    //                        })
                    //                        Spacer()
                    //                        Button(action: {graphType = .km}, label: {
                    //                            Text("KMs")
                    //                        })
                    //                    }
                    //                    .foregroundColor(Color("Wine"))
                    //                    .padding()
                }.padding()
                
                // MARK: - Graphic
                getGraphData(type: graphType)
            }
            .navigationBarTitle("Vehicle Stats", displayMode: .inline)
        }
    }
    
    enum GraphType {
        // swiftlint:disable identifier_name
        case spending, dates, km
    }
    
    func getGraphData(type: GraphType) -> some View {
        switch type {
        case .spending:
            return LineView(data: tracker.refuels.map { $0.money }, title: "Spending")
            
        case .dates:
            return LineView(data: tracker.refuels.map {
                                Double($0.creationDate.timeIntervalSince1970) },
                            title: "Refuel Date")
        // graph is not the best way to visualize when the refuels were made. think of something better
        case .km:
            return LineView(data: tracker.refuels.map { $0.kmAdded }, title: "KM per Refuel")
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
