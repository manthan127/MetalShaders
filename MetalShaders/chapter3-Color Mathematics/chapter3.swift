//
//  chapter3.swift
//  MetalShaders
//
//  Created by macm4 on 21/04/26.
//

import SwiftUI

struct Chapter3Shaders: View {
    enum ShaderType: String, CommonShaders {
        case original = "OG", saturate, brighten
        
        var id: String { self.rawValue }
        var label: String {
            switch self {
            case .original: "Original"
            default: rawValue.separatingCapitals().capitalized
            }
        }
    }
    
    @State private var selectedShader: ShaderType = .saturate
    
    var body: some View {
        Image(.sample)
            .resizable()
            .scaledToFit()
            .visualEffect { content, proxy in
                content.colorEffect(selectedShader.shader(.float2(proxy.size)))
            }
        
        Picker("Shader", selection: $selectedShader) {
            ForEach(ShaderType.allCases) { shader in
                Text(shader.label).tag(shader)
            }
        }
        .pickerStyle(.menu)
        .padding()
    }
}

#Preview {
    Chapter3Shaders()
}
