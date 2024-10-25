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
            
            Spacer()
                .frame(height: 40)
            
            List {
                    Text("A List Item")
                    Text("A Second List Item")
                    Text("A Third List Item")
                }
            .scrollContentBackground(.hidden)
        }
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
