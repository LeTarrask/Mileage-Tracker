//
//  OnboardingView.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 25/03/2021.
//
// TUTORIAL: https://www.avanderlee.com/swiftui/dynamic-pager-view-onboarding/

import SwiftUI

struct OnboardingView: View {
    @Environment(\.presentationMode) var presentationMode

    @EnvironmentObject var settingsMG: SettingsManager

    @State private var currentPage: OnboardingPage = .welcome
    private let pages: [OnboardingPage]

    init(pages: [OnboardingPage]) {
        self.pages = pages
    }

    var body: some View {
        VStack {
            ForEach(pages, id: \.self) { page in
                if page == currentPage {
                    page.view(action: showNextPage)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .transition(AnyTransition.asymmetric(
                                        insertion: .move(edge: .trailing),
                                        removal: .move(edge: .leading))
                        )
                }
            }

            HStack {
                ForEach(pages, id: \.self) { page in
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(page == currentPage ? settingsMG.theme.mainColor : settingsMG.theme.highlightColor)
                }
            }

            Group {
                if currentPage.shouldShowNextButton {
                    HStack {
                        Spacer()
                        Button(action: showNextPage, label: {
                            Text(nextLabel)
                                .foregroundColor(settingsMG.theme.mainColor)
                        })
                    }
                }
                if currentPage.shouldShowDismissButton {
                    HStack {
                        Spacer()
                        Button(dismissLabel) { dismissOnboarding() }
                            .foregroundColor(settingsMG.theme.mainColor)
                    }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 50, bottom: 50, trailing: 50))
            .transition(AnyTransition.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading))
            )
        }
        .onAppear {
            self.currentPage = pages.first!
        }
    }

    private func dismissOnboarding() {
        presentationMode.wrappedValue.dismiss()
    }

    private func showNextPage() {
        guard let currentIndex = pages.firstIndex(of: currentPage), pages.count > currentIndex + 1 else {
            return
        }
        withAnimation(.spring()) {
            currentPage = pages[currentIndex + 1]
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        let pages = OnboardingPage.fullOnboarding
        return OnboardingView(pages: pages)
                .environmentObject(SettingsManager.shared)
    }
}
