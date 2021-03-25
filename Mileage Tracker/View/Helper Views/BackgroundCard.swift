//
//  BackgroundCard.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 25/03/2021.
//

import SwiftUI

struct BackgroundCard: View {
    var theme: Theme = ThemeManager.currentTheme()

    var body: some View {
        LinearGradient(gradient:
                        Gradient(colors: [theme.secondaryColor, theme.mainColor]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
            .cornerRadius(15)
            .shadow(color: .black, radius: 3, x: 2, y: 1)
    }
}

struct BackgroundCard_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundCard()
    }
}
