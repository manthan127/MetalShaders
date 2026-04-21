//
//  HelperFuncs.metal
//  MetalShaders
//
//  Created by macm4 on 21/04/26.
//

#include <metal_stdlib>
using namespace metal;

struct Colors {
    static constant half4 red;
    static constant half4 green;
    static constant half4 blue;
    static constant half4 black;
    static constant half4 white;
};

constant half4 Colors::red   = half4(1, 0, 0, 1);
constant half4 Colors::green = half4(0, 1, 0, 1);
constant half4 Colors::blue  = half4(0, 0, 1, 1);
constant half4 Colors::black = half4(0, 0, 0, 1);
constant half4 Colors::white = half4(1, 1, 1, 1);

half4 grayColor(half n, half alpha = 0.5) {
    return half4(n, n, n, alpha);
}


// MARK: - need to revisit these four functions for better type mannagement
float3 rgb2hsv(float3 c) {
    float4 K = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    float4 p = mix(float4(c.bg, K.wz), float4(c.gb, K.xy), step(c.b, c.g));
    float4 q = mix(float4(p.xyw, c.r), float4(c.r, p.yzx), step(p.x, c.r));
    
    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return float3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

half3 rgb2hsv(half3 c) {
    return half3(rgb2hsv(float3(c)));
}

// HSV→RGB
float3 hsv2rgb(float3 c) {
    float4 K = float4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    float3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

half3 hsv2rgb(half3 c) {
    return half3(hsv2rgb(float3(c)));
}
