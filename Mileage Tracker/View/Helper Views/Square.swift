//
//  Square.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 25/03/2021.
//

import SwiftUI

struct Square: View {
    @StateObject var themeMG: ThemeManager = ThemeManager.shared
    
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
                    .foregroundColor(number < 0 ? .green : flip ? .red : themeMG.theme.backgroundColor)
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
        .foregroundColor(themeMG.theme.mainColor)
    }
}
