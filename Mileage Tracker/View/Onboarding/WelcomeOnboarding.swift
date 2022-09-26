//
//  WelcomeOnboarding.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 29/03/2021.
//

import SwiftUI

struct WelcomeOnboarding: View {
    @StateObject var themeMG: ThemeManager = ThemeManager.shared

    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "drop.fill")
                .resizable()
                .frame(width: 200, height: 300)
            Text("Welcome to Fuellogue")
                .font(.title)
                .fontWeight(.bold)
            Text("Track your bike fuel expenses, other payments and vehicle mileage. See the data in a fancy SwiftUI Chart.")
                .font(.body)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 30)
                .padding(.top, 5)
        }
        .foregroundColor(themeMG.theme.mainColor)
    }
}

struct WelcomeOnboarding_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeOnboarding()
    }
}
