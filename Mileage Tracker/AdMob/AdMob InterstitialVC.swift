//
//  Google Ad Interstitial.swift
//  2048
//
//  Created by Alex Luna on 11/03/2021.
//

import SwiftUI
import GoogleMobileAds
import UIKit

final class Interstitial: NSObject, GADFullScreenContentDelegate {
    var interstitial: GADInterstitialAd?
    let interstitialID = "ca-app-pub-3940256099942544/4411468910"
    
    override init() {
        super.init()
        loadInterstitial()
    }
    
    func loadInterstitial() {
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID: interstitialID,
                               request: request,
                               completionHandler: { [self] foundAd, error in
                                if let error = error {
                                    print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                                    return
                                }
                                interstitial = foundAd
                                interstitial?.fullScreenContentDelegate = self
                               }
        )
    }
    
    func showAd() {
        if interstitial != nil {
            let root = UIApplication.shared.windows.first?.rootViewController
            interstitial!.present(fromRootViewController: root!)
        } else {
            print("Not Ready")
        }
    }
    
    /// Tells the delegate that the ad failed to present full screen content.
      func ad(_ advert: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Ad did fail to present full screen content.")
      }

      /// Tells the delegate that the ad presented full screen content.
      func adDidPresentFullScreenContent(_ advert: GADFullScreenPresentingAd) {
        print("Ad did present full screen content.")
      }

      /// Tells the delegate that the ad dismissed full screen content.
      func adDidDismissFullScreenContent(_ advert: GADFullScreenPresentingAd) {
        print("Ad did dismiss full screen content.")
      }
}
