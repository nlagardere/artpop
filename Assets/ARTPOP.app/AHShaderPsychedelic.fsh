//
//  AHShaderPsychedelic.fsh
//  ArtHaus
//
//  Created by Chris Osborn on 10/29/13.
//  Copyright (c) 2013 RelativeWave. All rights reserved.
//

precision mediump float;
varying vec3 v_normal;
uniform vec3 u_colorAmbient;
uniform vec3 u_colorDiffuse;
uniform lowp float u_alpha;
uniform vec3 u_lightDirection;

void main() {
    vec3 L = normalize(-u_lightDirection);
    vec3 N = normalize(v_normal);
    
    vec3 Ka = u_colorAmbient;
    vec3 Kd = u_colorDiffuse * max(dot(N, L), 0.0);
    
    gl_FragColor = vec4(Ka + Kd, u_alpha);
}
