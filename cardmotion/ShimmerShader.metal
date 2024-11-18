//
//  MetalShader.metal
//  cardmotion
//
//  Created by Armond Schneider on 11/17/24.
//

#include <metal_stdlib>
using namespace metal;

struct VertexOut {
    float4 position [[position]];
    float2 textureCoords;
};

vertex VertexOut vertexShader(uint vertexID [[vertex_id]]) {
    VertexOut out;
    float2 positions[4] = { {-1.0, -1.0}, {1.0, -1.0}, {-1.0, 1.0}, {1.0, 1.0} };
    out.position = float4(positions[vertexID], 0, 1);
    out.textureCoords = (positions[vertexID] + 1) * 0.5;
    return out;
}

fragment float4 fragmentShader(VertexOut in [[stage_in]], constant float &shimmerIntensity [[buffer(0)]]) {
    float shimmer = abs(sin(in.textureCoords.x * 10.0 + in.textureCoords.y * 10.0 + shimmerIntensity));
    float4 color = float4(1.0, 1.0, 1.0, shimmer); // Adjust alpha for subtle shimmer
    return color;
}
