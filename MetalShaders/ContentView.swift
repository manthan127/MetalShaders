//
//  ContentView.swift
//  MetalShaders
//
//  Created by Home on 20/10/25.
//

import SwiftUI

struct ContentView: View {
    @State private var brightness: Float = 0.5
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
            Text("Hello, world!")
                .foregroundStyle(.tint).colorEffect(ShaderLibrary.solidRed(.float(brightness)))
        }
        .padding()
        .overlay(alignment: .bottom) {
            Slider(value: $brightness, in: 0...1)
                .padding()
        }
    }
}

struct InteractiveShader: View {
    @State private var brightness: Float = 0.5
    var body: some View {
        Image("sample")
            .colorEffect(ShaderLibrary.adjustableBrightness(.float(brightness)))
            .overlay(alignment: .bottom) {
                Slider(value: $brightness, in: 0...1)
                    .padding()
            }
    }
}

#Preview {
    ContentView()
}
