//
//  OnboardingPage.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 25/03/2021.
//

import SwiftUI

enum OnboardingPage: CaseIterable {
     case welcome
     case newFeature
     case sales

     static let fullOnboarding = OnboardingPage.allCases

    var shouldShowNextButton: Bool {
         switch self {
         case .welcome, .newFeature:
             return true
         default:
             return false
         }
     }

    var shouldShowDismissButton: Bool {
         switch self {
         case .sales:
             return true
         default:
             return false
         }
     }

     @ViewBuilder
     func view(action: @escaping () -> Void) -> some View {
         switch self {
         case .welcome:
            VStack {
                WelcomeOnboarding()
            }
         case .newFeature:
            VStack {
                NewFeatureOnboarding()
            }
         case .sales:
             SalesOnboarding()
         }
     }
 }
