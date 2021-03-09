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
            List(tracker.otherCosts.reversed()) { cost in
                HStack {
                    Text(cost.name)
                    Spacer()
                    Text(String(cost.value))
                    Spacer()
                    Text(dateToString(date: cost.creationDate))
                }.background(cost.type == .tax ? Color.red : Color.blue)
            }
            .navigationBarTitle(NSLocalizedString("Other vehicle costs", comment: ""), displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button(action: { self.isPresented.toggle() }, label: {
                                        Image(systemName: "plus.circle")
                                    }))
            .sheet(isPresented: $isPresented) {
                NavigationView {
                    AddCostView(costData: $newCostData)
                        .navigationBarItems(leading: Button(NSLocalizedString("Dismiss", comment: "")) {
                            newCostData = OtherCost.Data()
                            isPresented = false
                        }, trailing: Button(NSLocalizedString("Save", comment: "")) {
                            if true { // replace true pelas condições de salvar os dados
                                // TO DO: pode arredondar a double do valor para 2 centavos
                                // TO DO: nao deixar salvar se for um numero
                                // TO DO: ver se dá pra impedir a parada da virgula
                                let newCost = OtherCost(type: newCostData.type, value: newCostData.value, name: newCostData.name)
                                tracker.otherCosts.append(newCost)
                                newCostData = OtherCost.Data()
                                isPresented = false
                            } else {
                                // mostrar ajuda para preencher o numero
                            }
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
