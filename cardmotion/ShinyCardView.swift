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
                        gradient: Gradient(colors: [
                            Color(red: 0.95, green: 0.32, blue: 0.43),
                            Color(red: 1, green: 0, blue: 0.53)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .black.opacity(0.2), radius: 20, y: 2)
                
                // Rotation Effect
                .rotation3DEffect(
                    .degrees(Double(clamp(value: adjustedRoll() * 12, lower: -10, upper: 10))),
                    axis: (x: 1.0, y: 0.0, z: 0.0)
                )
                .rotation3DEffect(
                    .degrees(Double(clamp(value: adjustedPitch() * 12, lower: -10, upper: 10))),
                    axis: (x: 0.0, y: 1.0, z: 0.0)
                )
                .overlay(
                    ReflectionView()
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .opacity(0.5)
                )
                .frame(width: 330, height: 200)
                .padding()
                .overlay(
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: Color(red: 0.95, green: 0.32, blue: 0.43), location: 0.00),
                            Gradient.Stop(color: Color(red: 1, green: 0, blue: 0.53), location: 1.00)
                        ],
                        startPoint: UnitPoint(x: 0.6, y: 0.5),
                        endPoint: UnitPoint(x: 0.98, y: 1)
                    )
                    .blendMode(.overlay)
                )
                .animation(.easeOut(duration: 0.2), value: motionManager.pitch + motionManager.roll) // Smooth transitions
        }
    }

    // MARK: - Adjust Pitch
    private func adjustedPitch() -> CGFloat {
        let pitch = motionManager.pitch

        // This should keep card flat when holding phone vertically
        if abs(pitch) > .pi / 2 - 0.1 {
            return 0
        }
        return pitch
    }

    // MARK: - Adjust Roll (Inverted)
    private func adjustedRoll() -> CGFloat {
        return -motionManager.roll
    }

    // MARK: - Clamp Function to Avoid Excess Rotation
    private func clamp(value: CGFloat, lower: CGFloat, upper: CGFloat) -> CGFloat {
        min(max(value, lower), upper)
    }
}

// MARK: - Preview
struct ShinyCard_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
