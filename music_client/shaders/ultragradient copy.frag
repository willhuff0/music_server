#version 460 core

precision highp float;

#include <flutter/runtime_effect.glsl>

const int numPoints = 4;

uniform float outputIntensity;
uniform vec2[numPoints] uPointPositions;
uniform float[numPoints] uPointSizes;
uniform vec3[numPoints] uPointColors;

out vec4 fragColor;

float falloff(float dist, float size) {
    return 1 - clamp(dist / size, 0.0, 1.0);
}

void main() {
    vec2 fragPosition = FlutterFragCoord().xy;

    vec4 totalColor = vec4(0.0);
    for(int i = 0; i < numPoints; i++) {
        vec2 pointPosition = uPointPositions[i];
        float pointSize = uPointSizes[i];
        vec3 pointColor = uPointColors[i];

        float dist = distance(pointPosition, fragPosition);
        float intensity = falloff(dist, pointSize);

        totalColor += vec4(pointColor, 1.0) * intensity;
    }
    
    fragColor = totalColor * outputIntensity;
}