//
//  PlusMenu.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 26/03/2021.
//

import SwiftUI

struct PlusMenu: View {
    @StateObject var themeMG: ThemeManager = ThemeManager.shared

    @StateObject var viewRouter: ViewRouter

    let widthAndHeight: CGFloat

    var body: some View {
        HStack(spacing: 50) {
            ZStack {
                Circle()
                    .foregroundColor(themeMG.theme.mainColor)
                    .frame(width: widthAndHeight, height: widthAndHeight)
                Image(systemName: "drop.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(15)
                    .frame(width: widthAndHeight, height: widthAndHeight)
                    .foregroundColor(.white)
            }
            .onTapGesture {
                viewRouter.currentPage = .addrefuel
            }
            ZStack {
                Circle()
                    .foregroundColor(themeMG.theme.mainColor)
                    .frame(width: widthAndHeight, height: widthAndHeight)
                Image(systemName: "wrench.and.screwdriver")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(15)
                    .frame(width: widthAndHeight, height: widthAndHeight)
                    .foregroundColor(.white)
            }
            .onTapGesture {
                viewRouter.currentPage = .addcost
            }
        }.transition(.scale)
        .animation(.easeInOut)
    }
}
