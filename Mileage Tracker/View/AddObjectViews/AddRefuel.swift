//
//  AddRefuel.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 22/07/2020.
//

import SwiftUI
import Combine

struct AddRefuel: View {
    @StateObject var themeMG: ThemeManager = ThemeManager.shared
    
    @ObservedObject var tracker = MileageTracker.shared
    
    @State var refuelData = Refuel.Data()
    
    enum Field {
        case km, liters, cost
    }
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text(addInfoLabel)) {
                    // MARK: - KM
                    HStack {
                        Text(kmLabel)
                        Spacer()
                        TextField("", text: $refuelData.kmString)
                            .keyboardType(.decimalPad)
                            .focused($focusedField, equals: .km)
                            .submitLabel(.next)
                    }
                    // MARK: - Liters
                    HStack {
                        Text(literLabel)
                        Spacer()
                        TextField("", text: $refuelData.litersString)
                            .keyboardType(.decimalPad)
                            .focused($focusedField, equals: .liters)
                            .submitLabel(.next)
                    }
                    // MARK: - Cost
                    HStack {
                        Text(costLabel)
                        Spacer()
                        TextField("", text: $refuelData.moneyString)
                            .focused($focusedField, equals: .cost)
                            .submitLabel(.done)
                            .keyboardType(.decimalPad)
                    }
                }
                
                Button(saveLabel) {
                    saveRefuel()
                }
            }   .foregroundColor(themeMG.theme.mainColor)
                .onSubmit {
                    switch focusedField {
                    case .km:
                        focusedField = .liters
                    case .liters:
                        focusedField = .cost
                    case .cost:
                        focusedField = .none
                    case .none:
                        focusedField = nil
                    }
                }
        }
    }
    
    func saveRefuel() {
        tracker.receiveNew(refuelData)
        tracker.save()
        refuelData = Refuel.Data()
        hideKeyboard()
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct AddRefuel_Previews: PreviewProvider {
    static var previews: some View {
        AddRefuel()
    }
}
