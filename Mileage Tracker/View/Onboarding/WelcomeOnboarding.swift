//
//  WelcomeOnboarding.swift
// Fuel Logue
//
//  Created by Alex Luna on 29/03/2021.
//

import SwiftUI

struct WelcomeOnboarding: View {
    @EnvironmentObject var settingsMG: SettingsManager

    var body: some View {
        VStack(alignment: .leading) {
            Image("bike01")
                .resizable()
                .frame(height: 300)
            VStack(alignment: .leading, spacing: 30) {
                Text(onboardingHealine1)
                    .font(.title)
                    .fontWeight(.bold)
                Text(onboardingCopy1)
                    .font(.body)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(creditText1)
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 30)
        }
        .foregroundColor(settingsMG.theme.mainColor)
    }
}

struct WelcomeOnboarding_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeOnboarding()
            .environmentObject(SettingsManager.shared)
    }
}
 
