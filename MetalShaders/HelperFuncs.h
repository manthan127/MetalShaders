//
//  HelperFuncs.h
//  MetalShaders
//
//  Created by macm4 on 21/04/26.
//

#ifndef HelperFuncs_h
#define HelperFuncs_h

struct Colors {
    static constant half4 red;
    static constant half4 green;
    static constant half4 blue;
    static constant half4 black;
    static constant half4 white;
};

half4 grayColor(half, half = 1);

float3 rgb2hsv(float3 c);
half3 rgb2hsv(half3 c);

float3 hsv2rgb(float3 c);
half3 hsv2rgb(half3 c);

#endif /* HelperFuncs_h */
