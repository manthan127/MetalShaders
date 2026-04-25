//
//  chapter2.swift
//  MetalShaders
//
//  Created by Home on 21/10/25.
//

import SwiftUI

struct Chapter2Shaders: View {
    enum ShaderType: String, CommonShaders {
        case smoothCircle, circle, gridPattern, radialPattern
        case verticalGradient, diagonalGradient, radialGradient
        case ring, square, checkerboard, stripes, concentricCircles
    }

    @State private var selectedShader: ShaderType = .concentricCircles

    var body: some View {
        VStack {
            Rectangle()
                .visualEffect { content, proxy in
                    content.colorEffect(selectedShader.shader(.float2(proxy.size)))
                }
                .scaledToFit()
                .border(.red)

            Picker("Shader", selection: $selectedShader) {
                ForEach(ShaderType.allCases) { shader in
                    Text(shader.label).tag(shader)
                }
            }
            .pickerStyle(.menu)
            .padding()
        }
    }
}

struct SpotlightView: View {
    @State private var lightPos = CGPoint(x: 0.5, y: 0.5)
    
    var body: some View {
        GeometryReader { geo in
            Rectangle()
                .visualEffect { content, proxy in
                    content.colorEffect(MetalLibs.visible.spotlight(
                        .float2(proxy.size),
                        .float2(lightPos)
                    ))
                }
                .gesture(
                    DragGesture().onChanged { value in
                        lightPos = CGPoint(
                            x: value.location.x / geo.size.width,
                            y: value.location.y / geo.size.height
                        )
                    }
                )
        }
        .frame(width: 300, height: 300)
    }
}

struct RotatingPatternView: View {
    @State private var time: Float = 0
    
    var body: some View {
        //TimelineView(.animation) { timeline in
        Rectangle().visualEffect { content, proxy in
            content.colorEffect(MetalLibs.visible.rotatingPattern(
                .float2(proxy.size),
                .float(time)
                //.float(timeline.date.timeIntervalSinceReferenceDate)
            ))
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 1/60.0, repeats: true) { _ in
                time += 1/60.0
            }
        }
    }
}



#Preview {
    Chapter2Shaders()
}
