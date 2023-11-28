//
//  ContentView.swift
//  EcoPlay_ios_front
//
//  Created by mansouri sabri on 27/11/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            CarouselleView()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
