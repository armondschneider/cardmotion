//
//  ContentView.swift
//  cardmotion
//
//  Created by Armond Schneider on 10/23/24.
//

import SwiftUI

struct ContentView: View {
    @State var ValueTranslation : CGSize = .zero
    @State var isDragging = false
    var body: some View {
        ZStack{
            Image("mewtwo").resizable().scaledToFill()
                .frame(width: 316, height: 417)
                .overlay(
                    Rectangle()
                        .frame(width: 300, height: 60)
                        .colorInvert()
                        .blur(radius: 50)
                        .opacity(0.7)
                        .offset(x: -ValueTranslation.width / 1.5, y: -ValueTranslation.height / 1.5)
                    
                )
                .clipped()
        }
        .cornerRadius(20)
        .shadow(color: Color.purple.opacity(0.2), radius: 20, x: 0, y: 8)
        .shadow(color: Color.red.opacity(0.1), radius: 10, x: 0, y: 2)
        
        .rotation3DEffect(
            .degrees(isDragging ? 10 : 0),
            axis: (x: -ValueTranslation.height, y: ValueTranslation.width, z: 0.0)
        )
        .gesture(DragGesture()
            .onChanged({ value in
                withAnimation {
                    ValueTranslation = value.translation
                    isDragging = true
                }
            })
                .onEnded({ vaule in
                    withAnimation {
                        ValueTranslation = .zero
                        isDragging = false
                    }
                })
        )
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
