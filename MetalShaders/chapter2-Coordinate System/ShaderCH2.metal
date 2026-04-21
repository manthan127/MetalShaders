//
//  ShadersCH2.metal
//  MetalShaders
//
//  Created by Home on 21/10/25.
//

#include <metal_stdlib>
#include "../HelperFuncs.h"
using namespace metal;

//[[ stitchable ]] half4 horizontalGradient(float2 position, half4 color, float2 size) {
//    float2 uv = position / size;

[[ stitchable ]] half4 horizontalGradient(float2 position, half4 color, float2 size) {
    float2 uv = position / size;
    return half4(uv.y * uv.x, uv.x, uv.x, 1);
}


[[ stitchable ]] half4 circle (float2 position, half4 color, float2 size) {
    float2 uv = position / size;
    float2 len = uv - 0.5;  // Center at (0,0)
    
    float dist = length(len);  // Distance from center
    
    if (dist < 0.3) {
        return Colors::white;
    } else {
        return Colors::black;
    }
}

[[ stitchable ]] half4 smoothCircle (float2 position, half4 color, float2 size) {
    float2 uv = position / size;
    float2 center = uv - 0.5;
    float distance = length(center);
    float circle = 1.0 - smoothstep(0.29, 0.31, distance);
    
    return grayColor(circle);
}

[[ stitchable ]] half4 gridPattern (float2 position, half4 color, float2 size) {
    float2 uv = position / size;
    
    float2 grid = fract(uv * 8.0);
    
    // Draw lines at grid boundaries
    float lineWidth = 0.1;
    float lines = 0.0;
   
    if (grid.x < lineWidth || grid.y < lineWidth) {
        lines = 1;
    }
    
    return grayColor(lines);
}

[[ stitchable ]] half4 radialPattern(float2 position, half4 color, float2 size) {
    float2 uv = position / size;
    float2 center = uv - 0.5;
    float distance = length(center);
    
    float pattern = sin(distance * 20) * 0.5 + 0.5;
    return grayColor(pattern);
}

// MARK: - Challenge 1
[[ stitchable ]] half4 verticalGradient (float2 position, half4 color, float2 size) {
    float2 uv = position / size;
    return grayColor(uv.y);
}

[[ stitchable ]] half4 diagonalGradient (float2 position, half4 color, float2 size) {
    float2 uv = position / size;
    
    half shade = clamp(half(uv.x + uv.y) * 0.5, 0.0, 1.0);

    return grayColor(shade);
}

[[ stitchable ]] half4 radialGradient (float2 position, half4 color, float2 size) {
    float2 uv = position / size;
    float dist = 1 - length(uv - 0.5);
    return grayColor(dist);
}

// MARK: - Challenge 2
[[ stitchable ]] half4 ring (float2 position, half4 color, float2 size) {
    float2 uv = position / size;
    float2 center = uv - 0.5;
    float distance = length(center);
    
    if (distance > 0.2 && distance < 0.35) {
        return Colors::white;
    }
    return Colors::black;
}

// MARK: - using `abs` function instead of comparing using OR (`||`) in conditions
[[ stitchable ]] half4 square (float2 position, half4 color, float2 size) {
    float2 uv = position / size;
    if (abs(uv.x - 0.5) > 0.3 || abs(uv.y - 0.5) > 0.3) {
        return Colors::black;
    }
    return Colors::white;
}


[[ stitchable ]] half4 square2 (float2 position, half4 color, float2 size) {
    float2 uv = position / size;
    if (uv.x < 0.3 || uv.y < 0.3 || uv.x > 0.7 || uv.y > 0.7) {
        return Colors::black;
    }
    return Colors::white;
}

// MARK: - Challenge 3
[[ stitchable ]] half4 checkerboard (float2 position, half4 color, float2 size) {
    float2 uv = position / size;
    float2 grid = fract(uv * 4.0);
    
    if ((grid.x < 0.5 && grid.y < 0.5) || (grid.x > 0.5 && grid.y > 0.5)) {
        return Colors::black;
    }
    return Colors::white;
}

[[ stitchable ]] half4 stripes (float2 position, half4 color, float2 size) {
    float2 uv = position / size;
    
    float x = sin(uv.y * 20) * 0.5 + 0.5;
    return grayColor(x);
}

[[ stitchable ]] half4 concentricCircles (float2 position, half4 color, float2 size) {
    float2 uv = position / size;
    float2 center = uv - 0.5;
    float distance = length(center);
    
    float pattern = sin(distance * 30) * 0.5 + 0.5;
    return grayColor(pattern);
}


[[ stitchable ]] half4 spotlight (float2 position, half4 color, float2 size, float2 lightCenter) {
    float2 uv = position / size;
    float2 center = uv - lightCenter;
    
    float distance = length(center);
    float c = 1-distance;
    if (distance < 0.3) {
        return grayColor(c);
    } else {
        return Colors::black;
    }
}

[[ stitchable ]] half4 rotatingPattern (float2 position, half4 color, float2 size, float time) {
    return color;
}
