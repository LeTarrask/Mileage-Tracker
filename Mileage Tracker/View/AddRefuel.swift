//
//  AddRefuel.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 22/07/2020.
//

import SwiftUI
import Combine

struct AddRefuel: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var kilometers: String = "0.0"
    @State var liters = "0.0"
    @State var money = "0.0"
    
    @ObservedObject var tracker: MileageTracker
    
    var body: some View {
        Form {
            Section(header: Text("Add refuel info")) {
                HStack {
                    Text("Kilometers")
                    Spacer()
                    TextField("", text: $kilometers)
                        .keyboardType(UIKeyboardType.numbersAndPunctuation)
                        // Esta parte do Just eu tirei deste tutorial: https://stackoverflow.com/questions/58733003/swiftui-how-to-create-textfield-that-only-accepts-numbers
                        .onReceive(Just(kilometers)) { newValue in
                                        let filtered = newValue.filter { "0123456789.".contains($0) }
                                        if filtered != newValue {
                                            self.kilometers = filtered
                                        }
                        }
                }
                HStack {
                    Text("Liters")
                    Spacer()
                    TextField("", text: $liters)
                        .keyboardType(UIKeyboardType.numbersAndPunctuation)
                        .onReceive(Just(liters)) { newValue in
                                        let filtered = newValue.filter {
                                            /*
                                             
                                             \d*(\.\d+)
                                             
                                             */
                                            "0123456789.".contains($0) }
                                        if filtered != newValue {
                                            self.liters = filtered
                                        }
                        }
                }
                HStack {
                    Text("Refuel Cost")
                    Spacer()
                    TextField("", text: $money)
                        .keyboardType(UIKeyboardType.numbersAndPunctuation)
                        .onReceive(Just(money)) { newValue in
                                        let filtered = newValue.filter { "0123456789.".contains($0) }
                                        if filtered != newValue {
                                            self.liters = money
                                        }
                        }
                }
            }
            Section {
                Button("Save") {
                    // TO DO: Should validate user input
                    /*
                     Right now its possible to add two periods to number value, or more, and this will totally break calculation. How to sanitize that?
                     */
                    let refuel = Refuel(kilometers: Double(kilometers) ?? 0.0, liters: Double(liters) ?? 0.0, money: Double(money) ?? 0.0)
                    tracker.storeNewRefuel(refuel: refuel)
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

struct AddRefuel_Previews: PreviewProvider {
    static var previews: some View {
        AddRefuel(tracker: MileageTracker())
    }
}
