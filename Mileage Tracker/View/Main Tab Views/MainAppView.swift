//
//  MainAppTabs.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 26/03/2021.
//

import SwiftUI

struct MainAppView: View {
    @StateObject var themeMG: ThemeManager = ThemeManager.shared

    @ObservedObject var tracker = MileageTracker.shared

    @ObservedObject var viewRouter = ViewRouter.shared

    @State var showPopUp = false

    var body: some View {
        // TODO: We dont need a geometry reader here
        GeometryReader { geometry in
            VStack {
                // MARK: - Main Page Views Switcher
                mainSwitcher()
                // MARK: - Tab Bar
                tabBar(geometry: geometry)
            }
            .background(Color.blue)
            .edgesIgnoringSafeArea([.bottom, .horizontal])
            .onAppear {
                tracker.load()
            }
        }
        .onTapGesture {
            withAnimation(.easeInOut, {
                showPopUp.toggle()
            })
        }
    }
    
    @ViewBuilder
    func mainSwitcher() -> some View {
        Group {
            switch viewRouter.currentPage {
            case .mileage:
                MileageView()
            case .othercosts:
                OtherCostsView()
            case .addobject:
                AddObjectView()
            case .graphics:
                GraphicsView()
            case .settings:
                SettingsView()
            // TODO: Remove these cases if it compiles correctly
            case .addrefuel:
                AddRefuel()
            case .addcost:
                AddCostView()
            }
        }
    }
    
    @ViewBuilder
    func tabBar(geometry: GeometryProxy) -> some View {
        ZStack {
            HStack {
                // MileageView
                TabBarIcon(assignedPage: .mileage,
                           width: geometry.size.width/5,
                           height: geometry.size.height/28,
                           systemIconName: "drop.fill",
                           tabName: refuelsString)
                // OtherCostsView
                TabBarIcon(assignedPage: .othercosts,
                           width: geometry.size.width/5,
                           height: geometry.size.height/28,
                           systemIconName: "wrench.and.screwdriver",
                           tabName: otherCostsString)
                
                // TODO: Clean this, unused
                // Add Button
//                        ZStack {
//                            // MARK: - Plus Menu
//                            if showPopUp {
//                                plusMenu(widthAndHeight: geometry.size.width/7)
//                                    .offset(y: -geometry.size.height/11)
//                            }
//                            Circle()
//                                .foregroundColor(themeMG.theme.highlightColor)
//                                .frame(width: geometry.size.width/7,
//                                       height: geometry.size.width/7)
//                                .shadow(radius: 4)
//                            Image(systemName: "plus.circle.fill")
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: geometry.size.width/7-6,
//                                       height: geometry.size.width/7-6)
//                                .foregroundColor(themeMG.theme.mainColor)
//                                .rotationEffect(Angle(degrees: showPopUp ? 90 : 0))
//                        }
//                        .offset(y: -geometry.size.height/20)
//                        .onTapGesture {
//                            withAnimation(.easeInOut, {
//                                showPopUp.toggle()
//                            })
//                        }
                
                // New Add Button
                TabBarIcon(assignedPage: .addobject,
                           width: geometry.size.width/5,
                           height: geometry.size.height/28,
                           systemIconName: "plus.circle.fill",
                           // TODO: create translatable string for Add Cost
                           tabName: "Add Cost")
                
                // StatsView
                TabBarIcon(assignedPage: .graphics,
                           width: geometry.size.width/5,
                           height: geometry.size.height/28,
                           systemIconName: "list.star",
                           tabName: statsString)
                
                // SettingsView
                TabBarIcon(assignedPage: .settings,
                           width: geometry.size.width/5,
                           height: geometry.size.height/28,
                           systemIconName: "gearshape",
                           tabName: settingsString)
            }
            .animation(.easeInOut, value: 5)
            .frame(width: geometry.size.width, height: geometry.size.height/10)
            .background(themeMG.theme.backgroundColor.shadow(radius: 2))
        }
    }

    // TODO: Clean this. Unused
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
                showPopUp.toggle()
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
                showPopUp.toggle()
            }
        }
        .transition(.scale)
        .animation(.easeInOut, value: 5)
    }
}

struct MainAppTabs_Previews: PreviewProvider {
    static var previews: some View {
        MainAppView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("iPhone 14")
        
        MainAppView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            .previewDisplayName("iPhone 12")
    }
}
