//
//  ContentView.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 22/07/2020.
//

import SwiftUI

struct MileageView: View {
    @ObservedObject var tracker: MileageTracker

    @Environment(\.scenePhase) private var scenePhase
    let saveAction: () -> Void

    @State private var isPresented: Bool = false
    @State private var newRefuelData = Refuel.Data()

    var body: some View {
        NavigationView {
            VStack {
                // MARK: - Refuels list
                List {
                    ForEach(tracker.refuels.reversed(), id: \.self) { refuel in
                        RefuelCardView(refuel: refuel, average: tracker.averagePrice)
                    }.onDelete(perform: removeItem)
                } // .padding(.horizontal, -20)
                if !tracker.paidApp { Banner() }
            }
            .navigationBarTitle(NSLocalizedString("Mileage Tracker", comment: ""), displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button(action: { self.isPresented.toggle() },
                                           label: { PlusButton() }))
            .sheet(isPresented: $isPresented) {
                NavigationView {
                    AddRefuel(refuelData: $newRefuelData)
                        .navigationBarItems(leading: Button(NSLocalizedString("Dismiss", comment: "")) {
                            isPresented = false
                        }, trailing: Button(NSLocalizedString("Save", comment: "")) {
                            tracker.receiveNew(newRefuelData)
                            newRefuelData = Refuel.Data() // resets refuel data storage
                            isPresented = false
                        })
                }
            }
            .onChange(of: scenePhase) { phase in
                if phase == .inactive { saveAction() }
            }
        }
    }

    func removeItem(at offsets: IndexSet) {
        tracker.refuels.remove(atOffsets: offsets)
    }
}

struct PlusButton: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 9)
                .fill(Color("Yellowish"))
                .frame(width: 30, height: 30)
                .shadow(color: Color.black.opacity(0.2), radius: 4, x: 7, y: 5)
            Image(systemName: "plus")
                .foregroundColor(Color("Redder"))
        }
    }
}

struct RefuelCardView: View {
    var refuel: Refuel

    var average: Double

    var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()

    var body: some View {
        ZStack {
            BackgroundCard()
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Square(icon: "car",
                           number: refuel.kmAdded,
                           value: "km",
                           label: NSLocalizedString("Since last", comment: ""))
                    Spacer()
                    Square(icon: "drop.fill",
                           number: refuel.liters,
                           value: NSLocalizedString("L", comment: ""),
                           label: NSLocalizedString("Fuel", comment: ""))
                    Spacer()
                    Square(icon: "eurosign.square",
                           number: refuel.money,
                           value: NSLocalizedString("€", comment: ""),
                           label: NSLocalizedString("Payment", comment: ""))
                    Spacer()
                    Square(icon: "triangle.fill",
                           number: refuel.pricePerLiter-average,
                           value: NSLocalizedString("€", comment: ""),
                           label: NSLocalizedString("than average:", comment: ""))
                }
                .padding(.bottom)
                HStack {
                    Square(icon: nil,
                           number: refuel.pricePerLiter,
                           value: "€",
                           label: NSLocalizedString("per liter:", comment: ""))
                    Spacer()
                    Square(icon: nil,
                           number: refuel.totalKM,
                           value: NSLocalizedString("km", comment: ""),
                           label: NSLocalizedString("Total", comment: ""))
                }
                .padding(.bottom)
                HStack {
                    Text(NSLocalizedString("Refuel at: ", comment: ""))
                        .font(.caption)
                    Text(formatter.string(from: refuel.creationDate))
                        .font(.caption)
                }
                .foregroundColor(Color("Cream"))
            }.padding()
        }
    }
}

struct Square: View {
    let icon: String?
    let number: Double
    let value: String
    let label: String
    var flip: Bool {
        icon == "triangle.fill"
    }

    var body: some View {
        VStack(alignment: .center) {
            if icon != nil {
                Image(systemName: icon!)
                    .font(.largeTitle)
                    .rotationEffect(number < 0 ? .degrees(-180) : .zero)
                    .foregroundColor(number < 0 ? .green : flip ? .red : Color("Cream"))
            }
            VStack(alignment: .leading) {
                HStack {
                    Text(String(number.rounded(toPlaces: 2)))
                        .font(.subheadline)
                        .fontWeight(.bold)
                    Text(value)
                }
                Text(label)
                    .font(.caption)
            }
        }
        .foregroundColor(Color("Cream"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let view = MileageView(tracker: MileageTracker(), saveAction: {})
        view.tracker.refuels = Refuel.data
        return view
    }
}
