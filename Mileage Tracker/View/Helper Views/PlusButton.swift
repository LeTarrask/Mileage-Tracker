//
//  PlusButton.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 25/03/2021.
//

import SwiftUI

struct PlusButton: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 9)
                .fill(Color("Yellowish"))
                .frame(width: 30, height: 30)
                .shadow(color: Color.black.opacity(0.2), radius: 4, x: 7, y: 5)
            Image(systemName: "plus")
                .foregroundColor(Color("Redder"))
        }
    }
}

struct PlusButton_Previews: PreviewProvider {
    static var previews: some View {
        PlusButton()
    }
}
