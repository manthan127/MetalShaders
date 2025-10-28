//
//  chapter2.swift
//  MetalShaders
//
//  Created by Home on 21/10/25.
//

import SwiftUI

struct HorizontalGradient: View {
    var body: some View {
        Rectangle()
            .visualEffect { content, proxy in
                content
// .colorEffect(ShaderLibrary.smoothCircle(.float2(proxy.size)))
// .colorEffect(ShaderLibrary.circle(.float2(proxy.size)))
// .colorEffect(ShaderLibrary.gridPattern(.float2(proxy.size)))
// .colorEffect(ShaderLibrary.radialPattern(.float2(proxy.size)))
                
// .colorEffect(ShaderLibrary.verticalGradient(.float2(proxy.size)))
// .colorEffect(ShaderLibrary.diagonalGradient(.float2(proxy.size)))
// .colorEffect(ShaderLibrary.radialGradient(.float2(proxy.size)))
                
// .colorEffect(ShaderLibrary.ring(.float2(proxy.size)))
// .colorEffect(ShaderLibrary.square(.float2(proxy.size)))
                
                
// .colorEffect(ShaderLibrary.checkerboard(.float2(proxy.size)))
 .colorEffect(ShaderLibrary.stripes(.float2(proxy.size)))
// .colorEffect(ShaderLibrary.concentricCircles(.float2(proxy.size)))
            }
        .scaledToFit()
        .border(.red)
    }
}

#Preview {
    HorizontalGradient()
}
