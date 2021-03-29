//
//  NewFeatureOnboarding.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 29/03/2021.
//

import SwiftUI

struct NewFeatureOnboarding: View {
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

struct NewFeatureOnboarding_Previews: PreviewProvider {
    static var previews: some View {
        NewFeatureOnboarding()
    }
}
