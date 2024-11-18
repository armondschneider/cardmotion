//
//  ContentView.swift
//  cardmotion
//
//  Created by Armond Schneider on 10/23/24.
//

import SwiftUI

struct ContentView: View {
    @State private var rotationX: CGFloat = 0.0
    @State private var rotationY: CGFloat = 0.0
    @GestureState private var dragOffset = CGSize.zero
    @State private var shimmerIntensity: Float = 0.0

    var body: some View {
        ZStack {
            // Image as the card background
            Image("pika")
                .resizable()
                .scaledToFill()
                .frame(width: 300, height: 420)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .rotation3DEffect(
                    .degrees(Double(rotationX + dragOffset.height / 25)),
                    axis: (x: 1.0, y: 0.0, z: 0.0)
                )
                .rotation3DEffect(
                    .degrees(Double(rotationY - dragOffset.width / 25)),
                    axis: (x: 0.0, y: 1.0, z: 0.0)
                )
                .gesture(
                    DragGesture()
                        .updating($dragOffset) { value, state, _ in
                            state = value.translation
                        }
                        .onChanged { value in
                            rotationX = value.translation.height / 25
                            rotationY = -value.translation.width / 25
                            shimmerIntensity = Float((value.translation.width + value.translation.height).truncatingRemainder(dividingBy: 360)) / 100.0
                        }
                        .onEnded { _ in
                            withAnimation(.easeOut(duration: 0.5)) {
                                rotationX = 0
                                rotationY = 0
                                shimmerIntensity = 0.0
                            }
                        }
                )

            // Metal shimmer effect overlay with shimmer intensity tied to dragging
            MetalShimmerView(shimmerIntensity: $shimmerIntensity)
                .frame(width: 300, height: 420)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .opacity(0.5) // Adjust for a lighter or stronger shimmer
                .allowsHitTesting(false) // Ensures the gesture interacts with the card and not the overlay
        }
        .frame(width: 300, height: 420)
        .padding()
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
