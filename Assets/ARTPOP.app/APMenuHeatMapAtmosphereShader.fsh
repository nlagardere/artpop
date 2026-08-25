//
//  APMenuHeatMapAtmosphereShader.fsh
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
    vec4 diffuse = texture2D(u_sampler, v_texCoord);

    // Replace all black with alpha
    diffuse.w = 1.0 - ((3.0 - (diffuse.x + diffuse.y + diffuse.z)) / 3.0);
    
    vec3 L = normalize(lightDirection * u_modelMatrix);
    vec3 N = normalize(v_normalInterp);
    float NdotL = min(max(dot(N, L), 0.0), 1.0);
    
    vec4 finalColor = diffuse * vec4(NdotL, NdotL, NdotL, 1.0);
    
    gl_FragColor = finalColor;
}