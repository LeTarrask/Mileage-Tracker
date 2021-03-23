//
//  UIApplicationVersion.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 23/03/2021.
//

import UIKit

/// Used to display the app version in the menu and gets attached to feedback emails
extension UIApplication {
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}
