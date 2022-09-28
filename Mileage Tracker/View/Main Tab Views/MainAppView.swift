//
//  MainAppTabs.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 26/03/2021.
//

import SwiftUI

struct MainAppView: View {
    @StateObject var themeMG: ThemeManager = ThemeManager.shared

    @ObservedObject private var tracker = MileageTracker()

    @StateObject var viewRouter: ViewRouter = ViewRouter()

    @State var showPopUp = false

    var body: some View {
        GeometryReader { geometry in
            VStack {
                // MARK: - Main Page Views Switcher
                Group {
                    switch viewRouter.currentPage {
                    case .mileage:
                        MileageView(tracker: tracker)
                    case .othercosts:
                        OtherCostsView(tracker: tracker)
                    case .graphics:
                        GraphicsView(tracker: tracker)
                    case .settings:
                        SettingsView(tracker: tracker)
                    case .addrefuel:
                        AddRefuel(tracker: tracker)
                    case .addcost:
                        AddCostView(tracker: tracker)
                    }
                }
                // MARK: - Tab Bar
                ZStack {
                    HStack {
                        TabBarIcon(viewRouter: viewRouter,
                                   assignedPage: .mileage,
                                   width: geometry.size.width/5,
                                   height: geometry.size.height/28,
                                   systemIconName: "drop.fill",
                                   tabName: refuelsString)
                        TabBarIcon(viewRouter: viewRouter,
                                   assignedPage: .othercosts,
                                   width: geometry.size.width/5,
                                   height: geometry.size.height/28,
                                   systemIconName: "wrench.and.screwdriver",
                                   tabName: otherCostsString)
                        ZStack {
                            // MARK: - Plus Menu
                            if showPopUp {
                                plusMenu(widthAndHeight: geometry.size.width/7)
                                    .offset(y: -geometry.size.height/11)
                            }
                            Circle()
                                .foregroundColor(themeMG.theme.highlightColor)
                                .frame(width: geometry.size.width/7, height: geometry.size.width/7)
                                .shadow(radius: 4)
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width/7-6,
                                       height: geometry.size.width/7-6)
                                .foregroundColor(themeMG.theme.mainColor)
                                .rotationEffect(Angle(degrees: showPopUp ? 90 : 0))
                        }
                        .offset(y: -geometry.size.height/20)
                        .onTapGesture {
                            withAnimation(.easeInOut, {
                                showPopUp.toggle()
                            })
                        }
                        TabBarIcon(viewRouter: viewRouter,
                                   assignedPage: .graphics,
                                   width: geometry.size.width/5,
                                   height: geometry.size.height/28,
                                   systemIconName: "list.star",
                                   tabName: statsString)
                        TabBarIcon(viewRouter: viewRouter,
                                   assignedPage: .settings,
                                   width: geometry.size.width/5,
                                   height: geometry.size.height/28,
                                   systemIconName: "gearshape",
                                   tabName: settingsString)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height/10)
                    .background(themeMG.theme.backgroundColor.shadow(radius: 2))
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .onAppear {
                tracker.load()
            }
            .onTapGesture {
                withAnimation(.easeInOut, {
                    showPopUp = false
                })
            }
        }
    }

    @ViewBuilder
    func plusMenu(widthAndHeight: CGFloat) -> some View {
        HStack(spacing: 20) {
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
        }
        .transition(.scale)
        .animation(.easeInOut, value: 5)
    }

    /// VIEW STRINGS & URLs
    private let refuelsString = NSLocalizedString("Refuels", comment: "")
    private let otherCostsString = NSLocalizedString("Other costs", comment: "")
    private let statsString = NSLocalizedString("Stats", comment: "")
    private let settingsString = NSLocalizedString("Settings", comment: "")
}

struct MainAppTabs_Previews: PreviewProvider {
    static var previews: some View {
        MainAppView()
    }
}
