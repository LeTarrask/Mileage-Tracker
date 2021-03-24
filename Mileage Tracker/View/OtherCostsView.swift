//
//  OtherCostsView.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 15/01/2021.
//

import SwiftUI

struct OtherCostsView: View {
    @ObservedObject var tracker: MileageTracker
    
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: () -> Void

    @State private var isPresented: Bool = false
    @State private var newCostData = OtherCost.Data()

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15.0)
                            .frame(minHeight: 70, maxHeight: 80)
                            .padding()
                        HStack {
                            Text("Total Other Costs: ")
                            Text(String(tracker.totalOtherCosts))
                            Text(" €")
                        }.foregroundColor(.white)
                    }
                    ForEach(tracker.otherCosts.reversed()) { cost in
                        ZStack {
                            RoundedRectangle(cornerRadius: 15.0)
                                .fill(LinearGradient(gradient:
                                                        Gradient(colors: cost.type == .tax ?
                                                                    [Color("Redder"), Color("Wine")] :
                                                                    [Color("Cream"), Color("Yellowish")]),
                                                     startPoint: .topLeading,
                                                     endPoint: .bottomTrailing))
                                .frame(minHeight: 70, maxHeight: 80)
                            HStack(alignment: .bottom) {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Image(systemName: cost.type == .tax ? "folder" : "wrench.fill")
                                        Text(String(cost.value) + " €")
                                            .fontWeight(.bold)
                                    }
                                    Text(cost.name)
                                        .font(.subheadline)
                                }
                                Spacer()
                                Text(dateToString(date: cost.creationDate))
                                    .font(.caption)
                            }
                            .foregroundColor(cost.type == .tax ? Color("Cream") : Color("Wine"))
                            .padding()
                        }
                    }.padding(.horizontal)
                }
                Banner()
            }
            .navigationBarTitle(NSLocalizedString("Other vehicle costs", comment: ""), displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button(action: { isPresented.toggle() }, label: {
                                        PlusButton()
                                    }))
            .sheet(isPresented: $isPresented) {
                NavigationView {
                    AddCostView(costData: $newCostData)
                        .navigationBarItems(leading: Button(NSLocalizedString("Dismiss", comment: "")) {
                            newCostData = OtherCost.Data()
                            isPresented = false
                        }, trailing: Button(NSLocalizedString("Save", comment: "")) {
                            let newCost = OtherCost(type: newCostData.type,
                                                    value: newCostData.value,
                                                    name: newCostData.name)
                            tracker.otherCosts.append(newCost)
                            newCostData = OtherCost.Data()
                            isPresented = false
                        })
                }
            }
            .onChange(of: scenePhase) { phase in
                if phase == .inactive { saveAction() }
            }
        }
    }
}

extension OtherCostsView {
    func dateToString(date: Date) -> String {
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .medium
        return formatter1.string(from: date)
    }
}

struct OtherCostsView_Previews: PreviewProvider {
    static var previews: some View {
        let view = OtherCostsView(tracker: MileageTracker(), saveAction: {})
        view.tracker.otherCosts = OtherCost.data
        return view
    }
}
