//
//  APMenuHeatMapGlobeShader.fsh
//  ARTPOP
//
//  Created by Oleg Osin on 10/22/13.
//  Copyright (c) 2013 RelativeWave. All rights reserved.
//

varying vec3 v_normalInterp;
varying vec2 v_texCoord;
uniform sampler2D u_sampler;
uniform mat3 u_modelMatrix;

const vec3 lightDirection = vec3(0.0, 1.0, 0.0);

void main() {
    highp vec3 diffuse;
    
    diffuse = texture2D(u_sampler, v_texCoord).xyz;
    
    vec3 L = normalize(lightDirection * u_modelMatrix);
    vec3 N = normalize(v_normalInterp);
    float NdotL = min(max(dot(N, L), 0.0), 1.0);
    
    vec3 finalColor = diffuse * NdotL;
    
    gl_FragColor = vec4(finalColor, 1.0);
}