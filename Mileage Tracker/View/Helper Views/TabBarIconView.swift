//
//  TabBarIconView.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 26/03/2021.
//

import SwiftUI

struct TabBarIcon: View {
    @StateObject var themeMG: ThemeManager = ThemeManager.shared

    @StateObject var viewRouter = ViewRouter.shared
    
    let assignedPage: ViewRouter.Page

    let width: CGFloat = 30
    let height: CGFloat = 30
    let systemIconName, tabName: String

    var body: some View {
        VStack {
            Image(systemName: systemIconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .padding(.top, 10)
            Text(tabName)
                .font(.footnote)
            Spacer()
        }.padding(.horizontal, -4)
        .onTapGesture {
            viewRouter.currentPage = assignedPage
        }
        .foregroundColor(viewRouter.currentPage == assignedPage ?
                            themeMG.theme.secondaryColor : themeMG.theme.highlightColor)
    }
}
