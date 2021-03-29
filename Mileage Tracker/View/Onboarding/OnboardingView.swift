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
                        .animation(.default)
                }
            }

            Group {
                if currentPage.shouldShowNextButton {
                    HStack {
                        Spacer()
                        Button(action: showNextPage, label: {
                            Text("Next")
                        })
                    }
                }
                if currentPage.shouldShowDismissButton {
                    HStack {
                        Spacer()
                        Button("Dismiss") { dismissOnboarding() }
                    }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 50, bottom: 50, trailing: 50))
            .transition(AnyTransition.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading))
            )
            .animation(.default)
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
        currentPage = pages[currentIndex + 1]
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        let pages = OnboardingPage.fullOnboarding
        return OnboardingView(pages: pages)
    }
}
