//
//  InterstitialView.swift
//  2048
//
//  Created by Alex Luna on 11/03/2021.
//

import SwiftUI

struct InterstitialView: View {
    var interstitial: Interstitial
    
    init() {
        interstitial = Interstitial()
    }
    
    var body: some View {
        Button("Show ad") {
            interstitial.showAd()
        }
    }
}

struct InterstitialView_Previews: PreviewProvider {
    static var previews: some View {
        InterstitialView()
    }
}
