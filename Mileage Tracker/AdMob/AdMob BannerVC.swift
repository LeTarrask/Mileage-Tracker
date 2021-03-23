//
//  AdMob BannerVC.swift
//  2048
//
//  Created by Alex Luna on 11/03/2021.
//

// TO DO: When launching, the adUnitID number should be from the app's ad mob account
// the current one is for testing purposes

// used https://medium.com/@michaelbarneyjr/how-to-integrate-admob-ads-in-swiftui-fbfd3d774c50 tutorial
// and https://developers.google.com/admob/ios/quick-start?authuser=1 google instructions

import SwiftUI
import GoogleMobileAds
import UIKit

final class BannerVC: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> UIViewController {
        let view = GADBannerView(adSize: kGADAdSizeBanner)

        let viewController = UIViewController()
        let bannerID = "ca-app-pub-3940256099942544/2934735716"
        view.adUnitID = bannerID
        view.rootViewController = viewController
        viewController.view.addSubview(view)
        viewController.view.frame = CGRect(origin: .zero, size: kGADAdSizeBanner.size)
        view.load(GADRequest())

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
