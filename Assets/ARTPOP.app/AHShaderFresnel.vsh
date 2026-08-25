//
//  AHShaderFresnel.vsh
//  ArtHaus
//
//  Created by Chris Osborn on 9/12/13.
//  Copyright (c) 2013 RelativeWave. All rights reserved.
//

attribute vec4 a_position;
attribute vec3 a_normal;

varying vec3 v_refractDir;
varying vec3 v_reflectDir;
varying float v_fresnel;

uniform mat4 u_modelViewMatrix;
uniform mat3 u_normalMatrix;
uniform mat3 u_rotationMatrix;

const float k_air = 1.0;
const float k_glass = 1.51714;
const float k_eta = k_air / k_glass;
const float k_r0 = ((k_air - k_glass) * (k_air - k_glass)) / ((k_air + k_glass) * (k_air + k_glass));

// Vertex Animation Uniforms
uniform float u_translationX;
uniform float u_translationY;
uniform float u_rotationX;
uniform float u_rotationY;
uniform float u_scale;
uniform float u_twist;
uniform float u_spikiness;
uniform float u_rippleAmount;
uniform float u_rippleOffset;

// Vertex Animation Functions
float random(float p) {
    return fract(sin(p)*10000.0);
}

float noise(vec2 p) {
    // Somehow, calling fract a second time here fixed a bug with spiky on the 5S.
    return fract(random(p.x + p.y*1000.0));
}

#define M_PI 3.1415926535897932384626433832795

void main() {
    //// Vertex Animation Block ////
    vec4 p = a_position;
    
    // Twist
    float t = u_twist * (1.0 + p.y) * 0.5;
    p = vec4(p.z * sin(t) + p.x * cos(t),
             p.y,
             p.z * cos(t) - p.x * sin(t),
             p.w);
    
    /*
     // Bulge
     float b = 1.0 + u_bulge * (1.0 - pow(abs(p.y), 2.0));
     p = vec4(p.x * b,
     p.y,
     p.z * b,
     p.w);
     */
    
    // Ripple
    float b = 1.0 + 0.4 * u_rippleAmount * sin((1.0 + p.y + u_rippleOffset*2.0) * M_PI);
    p = vec4(p.x * b,
             p.y,
             p.z * b,
             p.w);
    
    // Spiky
    b = 1.0 + u_spikiness * noise(vec2(a_position.x, noise(a_position.yz))); // This is left as a_position because the position is used for predictable noise calculation.
    p = vec4(p.x * b,
             p.y * b,
             p.z * b,
             p.w);
    
    // Scale
    p = p * vec4(u_scale, u_scale, u_scale, 1.0);
    
    // Translate
    p = p + vec4(u_translationX, u_translationY, 0.0, 0.0);
    
    // Rotate X
    float rx = u_rotationX;
    p = vec4(p.x,
             p.y * cos(rx) - p.z * sin(rx),
             p.y * sin(rx) + p.z * cos(rx),
             p.w);
    
    // Rotate Y
    float ry = u_rotationY;
    p = vec4(p.z * sin(ry) + p.x * cos(ry),
             p.y,
             p.z * cos(ry) - p.x * sin(ry),
             p.w);
    
    /*
     // Rotate Z
     float rz = u_rotation.z;
     p = vec4(p.x * cos(rz) - p.y * sin(rz),
     p.x * sin(rz) + p.y * cos(rz),
     p.z,
     p.w);
     */
    
    //// Vertex Animation Block ////
    
    //// Normal Animation Block ////
    vec3 n = a_normal;
    
    // Twist
    n = vec3(n.z * sin(t) + n.x * cos(t),
             n.y,
             n.z * cos(t) - n.x * sin(t));
    
    // Rotate X
    n = vec3(n.x,
             n.y * cos(rx) - n.z * sin(rx),
             n.y * sin(rx) + n.z * cos(rx));
    
    // Rotate Y
    n = vec3(n.z * sin(ry) + n.x * cos(ry),
             n.y,
             n.z * cos(ry) - n.x * sin(ry));
    /*
     // Rotate Z
     n = vec3(n.x * cos(rz) - n.y * sin(rz),
     n.x * sin(rz) + n.y * cos(rz),
     n.z);
     */
    
    //// Normal Animation Block ////
    
	vec3 normal = normalize(u_normalMatrix * u_rotationMatrix * n);
	vec3 eyeDir = mat3(u_rotationMatrix) * vec3(0.0, 0.0, -1.0);
    
	v_refractDir = refract(eyeDir, normal, k_eta);
	v_reflectDir = reflect(eyeDir, normal);
	v_fresnel = k_r0 + (1.0 - k_r0) * pow((1.0 - dot(-eyeDir, normal)), 5.0);
    
	gl_Position = u_modelviewProjectionMatrix * p;
}