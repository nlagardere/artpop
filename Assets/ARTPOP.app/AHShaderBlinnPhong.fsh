//
//  AHShaderBlinnPhong.fsh
//  ArtHaus
//
//  Created by Max Weisel on 9/4/13.
//  Copyright (c) 2013 RelativeWave. All rights reserved.
//

precision mediump float;
varying vec3 v_normalInterp;
uniform sampler2D u_sampler;
uniform vec3 u_colorAmbient;
uniform vec3 u_colorDiffuse;
uniform vec3 u_colorSpecular;
uniform vec3 u_colorEmissive;
uniform float u_shininess;
uniform lowp float u_alpha;
uniform vec3 u_lightDirection;

const vec3 V = vec3(0.0, 0.0, 1.0);

void main() {
    vec3 L = normalize(-u_lightDirection);
    vec3 H = normalize(L + V);
    vec3 N = normalize(v_normalInterp);
    
    float NdotL = max(dot(N, L), 0.0);
    float NdotH = max(dot(N, H), 0.0);
    
    vec3 Ka = u_colorAmbient;
    vec3 Kd = u_colorDiffuse * NdotL;
    vec3 Ks = u_colorSpecular * pow(NdotH, u_shininess);
    vec3 Ke = u_colorEmissive;
    
    gl_FragColor = vec4(Ka + Kd + Ks + Ke, u_alpha);
}
