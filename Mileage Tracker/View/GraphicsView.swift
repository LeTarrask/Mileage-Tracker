//
//  GraphicsView.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 14/01/2021.
//

import SwiftUI
import SwiftUICharts // https://github.com/AppPear/ChartView

struct GraphicsView: View {
    @ObservedObject var tracker: MileageTracker
    
    @State var graphType: GraphType = .spending
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {graphType = .spending}, label: {
                    Text("Spending")
                })
                Button(action: {graphType = .dates}, label: {
                    Text("Refuel Dates")
                })
                Button(action: {graphType = .km}, label: {
                    Text("KMs")
                })
            }
            getGraphData(type: graphType)
        }
    }
    
    
    enum GraphType {
        case spending, dates, km
    }
    
    func getGraphData(type: GraphType) -> some View {
        switch type {
        case .spending:
            return LineView(data: tracker.refuels.map { $0.money }, title: "Spending")
                
        case .dates:
            return LineView(data: tracker.refuels.map { Double($0.creationDate.timeIntervalSince1970) }, title: "Refuel Date")
        // graph is not the best way to visualize when the refuels were made. think of something better
        case .km:
            return LineView(data: tracker.refuels.map { $0.kmAdded }, title: "KM per Refuel")
                
        }
    }
}


struct GraphicsView_Previews: PreviewProvider {
    static var previews: some View {
        let view = GraphicsView(tracker: MileageTracker())
        view.tracker.refuels = Refuel.data
        return view
    }
}
