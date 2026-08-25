//
//  AHShaderNormalMap.vsh
//  ArtHaus
//
//  Created by Chris Osborn on 9/17/13.
//  Copyright (c) 2013 RelativeWave. All rights reserved.
//

// Note: the iPhone 5 barfs if this is not highp
precision highp float;

attribute vec4 a_position;
attribute vec3 a_normal;
attribute vec3 a_tangent;
attribute vec3 a_binormal;
attribute vec2 a_texCoord;

varying vec2 v_texCoord;
varying vec3 v_viewDirection;
varying vec3 v_lightDirection;
varying vec3 v_halfDirection;

uniform mat3 u_modelViewMatrix;
uniform mat3 u_normalMatrix;
uniform vec3 u_lightDirection;

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
    
    gl_Position = u_modelviewProjectionMatrix * p;
    v_texCoord = a_texCoord;
    
    vec3 n_eye = normalize(u_normalMatrix * n);
	vec3 t_eye = normalize(u_normalMatrix * a_tangent);
    vec3 b_eye = cross(n_eye, t_eye);
    
	v_lightDirection.x = dot(u_lightDirection, t_eye);
	v_lightDirection.y = dot(u_lightDirection, b_eye);
	v_lightDirection.z = dot(u_lightDirection, n_eye);
	v_lightDirection = normalize(v_lightDirection);
	
	vec3 v = -(u_modelViewMatrix * (p.xyz / p.w));
    v_viewDirection.x = dot(v, t_eye);
	v_viewDirection.y = dot(v, b_eye);
	v_viewDirection.z = dot(v, n_eye);
	v_viewDirection = normalize(v_viewDirection);
    
    vec3 halfVector = normalize(normalize(v) + u_lightDirection);
	v_halfDirection.x = dot(halfVector, t_eye);
	v_halfDirection.y = dot(halfVector, b_eye);
	v_halfDirection.z = dot(halfVector, n_eye);
}
