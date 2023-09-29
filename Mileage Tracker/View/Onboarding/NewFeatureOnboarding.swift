//
//  NewFeatureOnboarding.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 29/03/2021.
//

import SwiftUI

struct NewFeatureOnboarding: View {
    @EnvironmentObject var settingsMG: SettingsManager

    var body: some View {
        VStack(alignment: .center) {
            Image("bike02")
                .resizable()
                .scaledToFill()
                .frame(height: 300)
                .clipped()
            VStack(alignment: .leading, spacing: 30) {
                Text(onboardingHealine2)
                    .font(.title)
                    .fontWeight(.bold)
                Text(onboardingCopy2)
                    .font(.body)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(creditText2)
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 30)
        }
        .foregroundColor(settingsMG.theme.mainColor)
    }
}

struct NewFeatureOnboarding_Previews: PreviewProvider {
    static var previews: some View {
        NewFeatureOnboarding()
            .environmentObject(SettingsManager.shared)
    }
}
