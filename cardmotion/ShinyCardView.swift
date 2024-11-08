//
//  ShinyCardView.swift
//  cardmotion
//
//  Created by Armond Schneider on 10/23/24.
//

import SwiftUI

struct ShinyCardView: View {
    @State private var rotationX: CGFloat = 0.0
    @State private var rotationY: CGFloat = 0.0
    @GestureState private var dragOffset = CGSize.zero

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
                
                .rotation3DEffect(
                    .degrees(Double(rotationY + dragOffset.width / 10)),
                    axis: (x: 0.0, y: 1.0, z: 0.0)
                )
                .rotation3DEffect(
                    .degrees(Double(rotationX - dragOffset.height / 10)),
                    axis: (x: 1.0, y: 0.0, z: 0.0)
                )
                .overlay(
                    ReflectionView()
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .opacity(0.5) // to do mirror effect
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
                .gesture(
                    DragGesture()
                        .updating($dragOffset) { value, state, _ in
                            state = value.translation
                        }
                        .onEnded { _ in
                            // reset
                            withAnimation(.easeOut(duration: 0.8)) {
                                rotationX = 0
                                rotationY = 0
                            }
                        }
                )
                .animation(.easeOut(duration: 0.2), value: rotationX + rotationY) // Smooth transitions
        }
    }
}

// MARK: - Preview
struct ShinyCard_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
