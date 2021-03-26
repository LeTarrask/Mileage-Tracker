//
//  OtherCostsView.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 15/01/2021.
//

import SwiftUI

struct OtherCostsView: View {
    @StateObject var themeMG: ThemeManager = ThemeManager.shared

    @ObservedObject var tracker: MileageTracker

    @Environment(\.scenePhase) private var scenePhase

    @State private var isPresented: Bool = false
    @State private var newCostData = OtherCost.Data()

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15.0)
                            .fill(LinearGradient(gradient: themeMG.theme.gradient1,
                                                 startPoint: .bottomLeading,
                                                 endPoint: .topTrailing))
                            .frame(minHeight: 70, maxHeight: 80)
                            .padding()

                        HStack {
                            Text("Total Other Costs: ")
                            Text(String(tracker.totalOtherCosts))
                            Text(" €")
                        }.foregroundColor(themeMG.theme.backgroundColor)
                    }
                    ForEach(tracker.otherCosts.reversed()) { cost in
                        ZStack {
                            RoundedRectangle(cornerRadius: 15.0)
                                .fill(LinearGradient(gradient:
                                                        cost.type == .tax ?
                                                        themeMG.theme.gradient1 :
                                                        themeMG.theme.gradient2,
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
                            .foregroundColor(cost.type == .tax ?
                                                themeMG.theme.backgroundColor : themeMG.theme.mainColor)
                            .padding()
                        }
                    }.padding(.horizontal)
                }
                if !tracker.paidApp { Banner() }
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
                if phase == .inactive { tracker.save() }
            }
        }
    }
}

struct OtherCostsView_Previews: PreviewProvider {
    static var previews: some View {
        let view = OtherCostsView(tracker: MileageTracker())
        view.tracker.otherCosts = OtherCost.data
        return view
    }
}
