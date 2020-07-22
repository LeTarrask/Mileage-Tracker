import UIKit

struct Refuel: Hashable {
    var kilometers: Double
    var liters: Double
    var money: Double
}

func FakeData() -> [Refuel]{
    var refuels = [Refuel]()
    for _ in 1...8 {
        let km = Double.random(in: 10.0 ..< 20.0)
        let liters = Double.random(in: 10.0 ..< 20.0)
        let money = Double.random(in: 10.0 ..< 20.0)
        let fuel = Refuel(kilometers: km, liters: liters, money: money)
        refuels.append(fuel)
    }
    return refuels
}

var refuels = FakeData()
