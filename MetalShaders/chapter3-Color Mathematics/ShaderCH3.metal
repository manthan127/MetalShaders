//
//  ShaderCH3.metal
//  MetalShaders
//
//  Created by macm4 on 21/04/26.
//

#include <metal_stdlib>
#include "../HelperFuncs.h"
using namespace metal;

// MARK: - helper functions

// Simplified but functional RGB→HSV
[[ stitchable ]] half4 brighten(float2 position, half4 color, float2 size) {
    // Increase brightness by 20%
    return half4(color.rgb * 1.2, color.a);
}

[[ stitchable ]] half4 saturate(float2 position, half4 color, float2 size) {
    half3 hsv = rgb2hsv(color.rgb);
    hsv.y = clamp(hsv.y * 1.5, 0.0, 1.0);  // Increase saturation by 50%
    return half4(hsv2rgb(hsv), color.a);
}
