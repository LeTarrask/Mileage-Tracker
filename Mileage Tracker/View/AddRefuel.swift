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
    
    @State var refuel: Refuel = Refuel(kilometers: 0.00, liters: 0.00, money: 0.00)
    
    @ObservedObject var tracker: MileageTracker
    
    var body: some View {
        Form {
            Section(header: Text("Add refuel info")) {
                HStack {
                    Text("Kilometers")
                    Spacer()
                    TextField("0.00", value: $refuel.kilometers, formatter: { () -> NumberFormatter in
                        let formater = NumberFormatter()
                        formater.groupingSeparator = ","
                        formater.maximumFractionDigits = 2
                        return formater
                    }())
                        .keyboardType(UIKeyboardType.numbersAndPunctuation)
                }
                HStack {
                    Text("Liters")
                    Spacer()
                    TextField("0.00", value: $refuel.liters, formatter: { () -> NumberFormatter in
                        let formater = NumberFormatter()
                        formater.groupingSeparator = ","
                        formater.maximumFractionDigits = 2
                        return formater
                    }(), onEditingChanged: { changed in
                        print(self.$refuel.kilometers)
                    })
                        .keyboardType(UIKeyboardType.numbersAndPunctuation)
                }
                HStack {
                    Text("Refuel Cost")
                    Spacer()
                    TextField("0.00", value: $refuel.money, formatter: { () -> NumberFormatter in
                        let formater = NumberFormatter()
                        formater.numberStyle = .currency
                        formater.maximumFractionDigits = 2
                        return formater
                    }())
                        .keyboardType(UIKeyboardType.numbersAndPunctuation)
                }
            }
            Section {
                Button("Save") {
                    print(refuel)
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
