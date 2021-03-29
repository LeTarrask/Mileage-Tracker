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
            Text("Main headline")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            Text("Main headline")
                .font(.body)
                .foregroundColor(.gray)
        }
        .foregroundColor(themeMG.theme.mainColor)
    }
}

struct WelcomeOnboarding_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeOnboarding()
    }
}
