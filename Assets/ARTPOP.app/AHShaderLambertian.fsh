//
//  AHShaderDiffuse.fsh
//  ArtHaus
//
//  Created by Max Weisel on 9/4/13.
//  Copyright (c) 2013 RelativeWave. All rights reserved.
//

precision mediump float;
varying vec3 v_normalInterp;
uniform vec3 u_colorAmbient;
uniform vec3 u_colorDiffuse;
uniform lowp float u_alpha;
uniform vec3 u_lightDirection;

void main() {
    vec3 L = normalize(-u_lightDirection);
    vec3 N = normalize(v_normalInterp);
    
    float NdotL = max(dot(N, L), 0.0);
    
    vec3 Ka = u_colorAmbient;
    
    vec3 Kd = u_colorDiffuse * NdotL;
    
    gl_FragColor = vec4(Ka + Kd, u_alpha);
}