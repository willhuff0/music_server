#version 460 core

precision highp float;

#include <flutter/runtime_effect.glsl>

uniform float outputIntensity;

uniform vec2 uPointPositions0;
uniform vec2 uPointPositions1;
uniform vec2 uPointPositions2;
uniform vec2 uPointPositions3;

uniform float uPointSizes0;
uniform float uPointSizes1;
uniform float uPointSizes2;
uniform float uPointSizes3;

uniform vec4 uPointColors0;
uniform vec4 uPointColors1;
uniform vec4 uPointColors2;
uniform vec4 uPointColors3;

out vec4 fragColor;

float falloff(float dist, float size) {
    return 1 - clamp(dist / size, 0.0, 1.0);
    //return smoothstep(size, 0.0, dist);
}


void main() {
    vec2 fragPosition = FlutterFragCoord().xy;

    vec4 totalColor = vec4(0.0);

    float dist = distance(uPointPositions0, fragPosition);
    float intensity = falloff(dist, uPointSizes0);
    totalColor += uPointColors0 * intensity;

    dist = distance(uPointPositions1, fragPosition);
    intensity = falloff(dist, uPointSizes1);
    totalColor += uPointColors1 * intensity;

    dist = distance(uPointPositions2, fragPosition);
    intensity = falloff(dist, uPointSizes2);
    totalColor += uPointColors2 * intensity;

    dist = distance(uPointPositions3, fragPosition);
    intensity = falloff(dist, uPointSizes3);
    totalColor += uPointColors3 * intensity;
    
    fragColor = totalColor * outputIntensity;
}