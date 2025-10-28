//
//  Shaders.metal
//  MetalShaders
//
//  Created by Home on 20/10/25.
//

#include <metal_stdlib>
using namespace metal;
//                                       position of pixel, color of pixel
//                                                |              |
//[[ stitchable ]] half4 <functionName>(float2 position, half4 color)

[[ stitchable ]] half4 solidRed(float2 position, half4 color) {
    return half4(1.0, 0.0, 0.0, 1.0);
}

[[ stitchable ]] half4 solidGreen(float2 position, half4 color) {
    return half4(0.0, 1.0, 0.0, 1.0);
}

[[ stitchable ]] half4 solidBlue(float2 position, half4 color) {
    return half4(0.0, 0.0, 1.0, 1.0);
}

[[ stitchable ]] half4 solidColor(float2 position, half4 color, float colorT) {
    switch (int(colorT)) {
        case 0:
            return half4(1.0, 0.0, 0.0, 1.0);
        case 1:
            return half4(0.0, 1.0, 0.0, 1.0);
        case 2:
            return half4(0.0, 0.0, 1.0, 1.0);
    }
    return half4(1.0, 1.0, 1.0, 1.0);
}

[[ stitchable ]] half4 adjustableBrightness(float2 position, half4 color, float brightness) {
    return half4(color.rgb * brightness, color.a);
}


[[ stitchable ]] half4 OG(float2 position, half4 color) {
    return color;
}
[[ stitchable ]] half4 redChannel(float2 position, half4 color) {
    return half4(color.rgb * half3(1,0,0), color.a);
}
[[ stitchable ]] half4 greenChannel(float2 position, half4 color) {
    return half4(color.rgb * half3(0,1,0), color.a);
}

[[ stitchable ]] half4 blueChannel(float2 position, half4 color) {
    return half4(color.rgb * half3(0,0,1), color.a);
}

[[ stitchable ]] half4 flagsColor(float2 position, half4 color, half4 col) {
    return col;
}

[[ stitchable ]] half4 pulsingColor(float2 position, half4 color, float time) {
    return half4(time, 0, 1-time, color.a);
}
