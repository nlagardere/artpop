//
//  AHShaderWireframe.fsh
//  ArtHaus
//
//  Created by Chris Osborn on 10/29/13.
//  Copyright (c) 2013 RelativeWave. All rights reserved.
//

precision highp float;
varying vec3 v_normal;
varying vec2 v_texCoord;
uniform vec3 u_colorDiffuse;
uniform vec3 u_lightDirection;
uniform float u_lineCount;
uniform float u_lineWidth;

void main() {
    vec2 t = v_texCoord * u_lineCount;
    
    // Diffuse Lighting
    vec3 L = normalize(-u_lightDirection);
    vec3 N = normalize(v_normal);
    float NdotL = max(dot(N, L), 0.0);
    vec4 color = vec4(u_colorDiffuse.rgb * NdotL, 1.0);
    
    if (fract(t.s) < u_lineWidth || fract(t.t) < u_lineWidth)
        gl_FragColor = color;
    else
        discard;
}
