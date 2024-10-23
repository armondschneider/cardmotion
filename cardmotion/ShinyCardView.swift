//
//  ShinyCardView.swift
//  cardmotion
//
//  Created by Armond Schneider on 10/23/24.
//


import SwiftUI

struct ShinyCardView: View {
    @ObservedObject var motionManager = MotionManager()

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [.blue, .purple]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .black.opacity(0.2), radius: 10, x: 10, y: 10)
                .rotation3DEffect(
                    .degrees(Double(motionManager.pitch * 30)),
                    axis: (x: 1.0, y: 0.0, z: 0.0)
                )
                .rotation3DEffect(
                    .degrees(Double(motionManager.roll * 30)),
                    axis: (x: 0.0, y: 1.0, z: 0.0)
                )
                .overlay(
                    ReflectionView()
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .opacity(0.5) // Mirror effect strength
                )
                .frame(width: 300, height: 500)
                .padding()
                .overlay(
                    AngularGradient(
                        gradient: Gradient(colors: [.white.opacity(0.3), .clear, .white.opacity(0.3)]),
                        center: .center,
                        startAngle: .degrees(-45),
                        endAngle: .degrees(45)
                    )
                    .blendMode(.overlay)
                )
        }
    }
}