//
//  MyShader.metal
//  GPU Testing
//
//  Created by Roman Esin on 09.08.2019.
//  Copyright © 2019 Mariya Esina. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

struct Vertex {
    simd_float3 pos [[ attribute(0) ]];
    simd_float4 color [[ attribute(1) ]];
};

struct RastData {
    simd_float4 pos [[ position ]];
    simd_float4 color;
};

struct ModelConstants {
    float4x4 matrix;
};

vertex RastData vertex_shader(const Vertex vIn [[ stage_in ]],
                              constant ModelConstants &modelConstants [[ buffer(1) ]],
                              constant float &time [[ buffer(2) ]]) {
    
    RastData rd;
    
    rd.pos = modelConstants.matrix * float4(vIn.pos, 1);
//    rd.pos.x += sin(time * 2) / 2;
//    rd.pos.y += cos(time * 2) / 2;
    rd.color = vIn.color;
    
    return rd;
}

fragment simd_half4 fragment_shader(RastData rd [[ stage_in ]]) {
//    float sinTime = sin(time);
//    float cosTime = cos(time);
//    float sinSizeX = sin(size.x / 20);
    
//    if (sinTime < 0) { sinTime *= -1.0; }
//
//    if (cosTime < 0) { cosTime *= -1.0; }
//
//    if (sinSizeX < 0) { sinSizeX *= -1.0; }
    
    return simd_half4(rd.color.r,
                      rd.color.g,
                      rd.color.b,
                      1.0);
}
