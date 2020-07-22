//
//  AddRefuel.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 22/07/2020.
//

import SwiftUI

struct AddRefuel: View {
    
    /*
     The problem with this view is that swiftUI shouldn't accept Doubles or Ints. It should convert to and fro, and send this data to the model
     */
    @Environment(\.presentationMode) var presentationMode
    
    @State var kilometers: Double = 0.0
    @State var liters: Double = 0.0
    @State var money: Double = 0.0
    
    @ObservedObject var tracker: MileageTracker
    
    var formatter: NumberFormatter {
        get {
            let formater = NumberFormatter()
            formater.groupingSeparator = ","
            formater.maximumFractionDigits = 2
            return formater
        }
    }
    
    var body: some View {
        Form {
            Section(header: Text("Add refuel info")) {
                HStack {
                    Text("Kilometers")
                    Spacer()
                    TextField("", value: $kilometers, formatter: formatter)
                        .keyboardType(UIKeyboardType.numberPad)
                }
                HStack {
                    Text("Liters")
                    Spacer()
                    TextField("", value: $liters, formatter: formatter)
                        .keyboardType(UIKeyboardType.numbersAndPunctuation)
                }
                HStack {
                    Text("Refuel Cost")
                    Spacer()
                    TextField("", value: $money, formatter: formatter)
                        .keyboardType(UIKeyboardType.numbersAndPunctuation)
                }
            }
            Section {
                Button("Save") {
                    //                    print(refuel)
                    //                    tracker.storeNewRefuel(refuel: refuel)
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
