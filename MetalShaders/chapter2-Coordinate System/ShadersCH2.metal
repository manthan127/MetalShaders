//
//  ShadersCH2.metal
//  MetalShaders
//
//  Created by Home on 21/10/25.
//

#include <metal_stdlib>
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
        return half4(1.0, 1.0, 1.0, 1.0);  // White inside
    } else {
        return half4(0.5, 0.5, 0.5, 1.0);  // Black outside
    }
}

[[ stitchable ]] half4 smoothCircle (float2 position, half4 color, float2 size) {
    float2 uv = position / size;
    float2 center = uv - 0.5;
    float distance = length(center);
    float circle = 1.0 - smoothstep(0.29, 0.31, distance);
    
    return half4(circle, circle, circle, 1.0);
    return half4(0, 0, 0, 1);
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
    
    return half4(lines, lines, lines, 1);
}

[[ stitchable ]] half4 radialPattern(float2 position, half4 color, float2 size) {
    float2 uv = position / size;
    float2 center = uv - 0.5;
    float distance = length(center);
    
    float pattern = sin(distance * 20) * 0.5 + 0.5;
    return half4(pattern, pattern, pattern, 1);
}

// MARK: - Challenge 1
[[ stitchable ]] half4 verticalGradient (float2 position, half4 color, float2 size) {
    float2 uv = position / size;
    return half4(uv.y, uv.y, uv.y, 1);
}

[[ stitchable ]] half4 diagonalGradient (float2 position, half4 color, float2 size) {
    float2 uv = position / size;
    
    float t = clamp((uv.x + uv.y) * 0.5, 0.0, 1.0);
    
    half shade = half(t);

    return half4(shade, shade, shade, 1);
}

[[ stitchable ]] half4 radialGradient (float2 position, half4 color, float2 size) {
    float2 uv = position / size;
    float dist = 1 - length(uv - 0.5);
    return half4(dist, dist, dist, 1);
}

// MARK: - Challenge 2
[[ stitchable ]] half4 ring (float2 position, half4 color, float2 size) {
    float2 uv = position / size;
    float2 center = uv - 0.5;
    float distance = length(center);
    
    if (distance > 0.2 && distance < 0.35) {
        return half4(1, 1, 1, 1);
    }
    return half4(0, 0, 0, 1);
}

// MARK: - using `abs` function instead of comparing using OR (`||`) in conditions
[[ stitchable ]] half4 square (float2 position, half4 color, float2 size) {
    float2 uv = position / size;
    if (abs(uv.x - 0.5) > 0.3 || abs(uv.y - 0.5) > 0.3) {
        return half4(0, 0, 0, 1);
    }
    return half4(1, 1, 1, 1);
}


[[ stitchable ]] half4 square2 (float2 position, half4 color, float2 size) {
    float2 uv = position / size;
    if (uv.x < 0.3 || uv.y < 0.3 || uv.x > 0.7 || uv.y > 0.7) {
        return half4(0, 0, 0, 1);
    }
    return half4(1, 1, 1, 1);
}

// MARK: - Challenge 3
[[ stitchable ]] half4 checkerboard (float2 position, half4 color, float2 size) {
    float2 uv = position / size;
    float2 grid = fract(uv * 4.0);
    
    if ((grid.x < 0.5 && grid.y < 0.5) || (grid.x > 0.5 && grid.y > 0.5)) {
        return half4(0, 0, 0, 1);
    }
    return half4(1, 1, 1, 1);
}

[[ stitchable ]] half4 stripes (float2 position, half4 color, float2 size) {
    float2 uv = position / size;
    float2 grid = fract(uv * 4.0);
    
    float x = smoothstep(0.3, 1, grid.y);
    return half4(x, x, x, 1);
}

[[ stitchable ]] half4 concentricCircles (float2 position, half4 color, float2 size) {
    return half4(1, 1, 1, 1);
}
