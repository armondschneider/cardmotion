//
//  ContentView.swift
//  cardmotion
//
//  Created by Armond Schneider on 10/23/24.
//

// ContentView.swift

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 20)
            
            ShinyCardView()

        }
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
