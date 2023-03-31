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
    
    @StateObject var tracker = MileageTracker.shared
    
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
                        Text(kmAddedLabel)
                        Spacer()
                        TextField("", text: $refuelData.kmString)
                            .keyboardType(.decimalPad)
                            .focused($focusedField, equals: .km)
                            .submitLabel(.next)
                    }
                    // MARK: - Liters
                    HStack {
                        Text(litersAddedLabel)
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
                }.buttonStyle(ColorButtonStyle())
            }
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
        .foregroundColor(themeMG.theme.mainColor)
        .scrollContentBackground(.hidden)
        .background(themeMG.theme.secondaryColor)
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

struct ColorButtonStyle: ButtonStyle {
    @StateObject var themeMG: ThemeManager = ThemeManager.shared
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.headline)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .contentShape(Rectangle())
            .foregroundColor(configuration.isPressed ? themeMG.theme.mainColor.opacity(0.5) : themeMG.theme.mainColor)
            .listRowBackground(configuration.isPressed ? themeMG.theme.mainColor.opacity(0.5) : themeMG.theme.mainColor)
    }
}

struct AddRefuel_Previews: PreviewProvider {
    static var previews: some View {
        AddRefuel().environmentObject(MileageTracker.shared)
    }
}
