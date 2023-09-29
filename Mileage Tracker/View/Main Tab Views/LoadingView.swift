//
//  Loading.swift
//  Dualogue
//
//  Created by Alex Luna on 29/06/2020.
//

import SwiftUI

struct LoadingView: View {
    @EnvironmentObject var settingsMG: SettingsManager
    
    var headline: String
    var paragraph: String
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                LoadingRectangle(width: geometry.size.width + 10,
                                 height: geometry.size.height,
                                 curveHeight: 10,
                                 curveLength: 2.5,
                                 speed: 1,
                                 color: settingsMG.theme.mainColor)
                VStack {
                    Text(headline)
                        .fontWeight(.black)
                        .font(.largeTitle)
                        .padding()
                    Text(paragraph)
                        .padding(.horizontal)
                }.foregroundColor(Color.white)
            }

        }.edgesIgnoringSafeArea(.all)
    }
}

struct LoadingRectangle: View {

    @State var width: CGFloat
    @State var height: CGFloat
    @State var curveHeight: CGFloat = 0
    @State var curveLength: CGFloat
    @State var speed: Double
    @State var color: Color

    @State private var time: Double = 0
    @State private var offsetY = 0
    @State private var animate = true

    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(width: width, height: height)
                ZStack {
                    Fluid(time: CGFloat(time*1.4),
                          width: width,
                          height: height,
                          curveHeight: curveHeight,
                          curveLength: curveLength)
                        .fill(color)
                        .frame(width: width, height: height)
                    Fluid(time: CGFloat(time),
                          width: width,
                          height: height,
                          curveHeight: curveHeight,
                          curveLength: curveLength)
                        .fill(color)
                        .opacity(0.5)
                        .frame(width: width, height: height)
                }
                .offset(x: 0, y: CGFloat(self.offsetY))
            }
            .mask(
                Rectangle()
                    .frame(width: width, height: height)
            )
        }
        .onTapGesture {
            self.animate.toggle()
        }
        .onAppear {
            self.offsetY = Int((self.height/2) + self.curveHeight)
            Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { _ in
                self.time += 0.01
                if self.offsetY >= (-Int((self.height/2) + self.curveHeight)) {
                    if self.animate {
                        withAnimation(Animation.linear(duration: 0.03)) {
                            self.offsetY -= 1
                        }
                    }
                }
            }
        }
    }
}

struct Fluid: Shape {
    var time: CGFloat
    let width: CGFloat
    let height: CGFloat
    let curveHeight: CGFloat
    let curveLength: CGFloat

    func path(in rect: CGRect) -> Path {
        return (
            Path { path in
                path.move(to: CGPoint(x: width, y: height*2))
                path.addLine(to: CGPoint(x: 0, y: height*2))
                for iteration in stride(from: 0, to: CGFloat(rect.width), by: 1) {
                    path.addLine(to: CGPoint(x: iteration,
                                             y: sin(((iteration / rect.height) + time)
                                                        * curveLength * .pi)
                                                        * curveHeight + rect.midY))
                }
                path.addLine(to: CGPoint(x: width, y: height*2))
            }
        )
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(headline: loadRefuelsHeadline, paragraph: loadRefuelParagraph)
            .environmentObject(SettingsManager.shared)
    }
}
