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
            Text("Headline with features and long ipsum uasdasdasd asdasda asd asdasdasd asd asd asdasd asd asd asd asd asd asd asd ad asdasasd asdasd asd")
                .font(.body)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 30)
                .padding(.top, 5)
        }
        .foregroundColor(themeMG.theme.mainColor)
    }
}

struct NewFeatureOnboarding_Previews: PreviewProvider {
    static var previews: some View {
        NewFeatureOnboarding()
    }
}
