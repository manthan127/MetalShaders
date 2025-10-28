//
//  chapter1.swift
//  MetalShaders
//
//  Created by Home on 20/10/25.
//

import SwiftUI

struct chapter1: View {
    @State var x: Int = 0
    
    var body: some View {
        Rectangle()
            .colorEffect(ShaderLibrary.solidColor(.float(Float(x))))
            .aspectRatio(contentMode: .fit)
            .padding()
        
        HStack {
            Button {
                x = 0
            } label: {
                Text("Red")
                    .padding()
                    .border(.red)
                    .foregroundStyle(.red)
            }
            
            Button {
                x = 1
            } label: {
                Text("Green")
                    .padding()
                    .border(.green)
                    .foregroundStyle(.green)
            }
            
            Button {
                x = 2
            } label: {
                Text("Blue")
                    .padding()
                    .border(.blue)
                    .foregroundStyle(.blue)
            }
        }
    }
}

struct Brightness: View {
    @State private var brightness: Float = 0.5
    var body: some View {
        VStack {
            Image(.sample)
                .resizable()
                .scaledToFit()
                .colorEffect(ShaderLibrary.adjustableBrightness(.float(brightness)))
            
            
            Text("Brightness: \(brightness)")
            Slider(value: $brightness, in: 0...1)
                .padding()
        }
    }
}

struct ColorChannelIsolation: View {
    enum ShaderType: String, CaseIterable {
        case original
        case red
        case green
        case blue
        
        var shader: Shader {
            switch self {
            case .original:
                ShaderLibrary.OG()
            case .red:
                ShaderLibrary.redChannel()
            case .green:
                ShaderLibrary.greenChannel()
            case .blue:
                ShaderLibrary.blueChannel()
            }
        }
    }
    
    @State private var picker: ShaderType = .original
    var body: some View {
        VStack {
            Image(.sample)
                .resizable()
                .scaledToFit()
                .colorEffect(picker.shader)
//                .colorEffect(ShaderFunction(library: ShaderLibrary.default, name: <#T##String#>))
            
            Picker(selection: $picker) {
                ForEach(ShaderType.allCases, id: \.self) { type in
                    Text(type.rawValue)
                }
            } label: {
                Text("")
            }
            .pickerStyle(.segmented)
            .padding()
        }
    }
}

struct FlagCreator: View {
    @State var Left: Color = .red
    @State var Middle: Color = .green
    @State var Right: Color = .blue
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                Rectangle()
                    .colorEffect(ShaderLibrary.flagsColor(.color(Left)))
                Rectangle()
                    .colorEffect(ShaderLibrary.flagsColor(.color(Middle)))
                Rectangle()
                    .colorEffect(ShaderLibrary.flagsColor(.color(Right)))
            }
            .border(.black)
            .aspectRatio(16/9, contentMode: .fit)
            
            ColorPicker("Left", selection: $Left)
            ColorPicker("Middle", selection: $Middle)
            ColorPicker("Right", selection: $Right)
            
            HStack {
                Button("France") {
                    Left = Color(red: 0, green: 0.3, blue: 0.6)
                    Middle = Color(red: 1, green: 1, blue: 1)
                    Right = Color(red: 1, green: 0, blue: 0)
                }
            }
        }
        .padding()
    }
}

struct AnimatedPulse: View {
    var body: some View {
        VStack(alignment: .leading) {
            TimelineView(.animation) { timeline in
                VStack(alignment: .leading) {
                    Rectangle()
                        .scaledToFit()
                        .colorEffect(ShaderLibrary.pulsingColor(
                            .float(abs(sin(timeline.date.timeIntervalSinceReferenceDate))) 
                        ))
                }
            }
        }
        .padding()
    }
    
//    var body: some View {
//        TimelineView(.animation) { context in
//            let value = secondsValue(for: context.date)
//            
//            Circle()
//                .trim(from: 0, to: value)
//                .stroke()
//        }
//    }
    
    private func secondsValue(for date: Date) -> Double {
        let seconds = Calendar.current.component(.second, from: date)
        return Double(seconds) / 60
    }
}

#Preview {
//    chapter1()
//    Brightness()
//    ColorChannelIsolation()
//    FlagCreator()
    AnimatedPulse()
}
