//
//  BannerView.swift
//  2048
//
//  Created by Alex Luna on 11/03/2021.
//

import SwiftUI

struct Banner: View {
    var body: some View {
        HStack {
            Spacer()
            BannerVC().frame(width: 320, height: 50, alignment: .center)
            Spacer()
        }
    }
}

struct Banner_Previews: PreviewProvider {
    static var previews: some View {
        Banner()
    }
}
