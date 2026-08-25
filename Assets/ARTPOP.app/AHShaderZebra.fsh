//
//  AHShaderZebra.fsh
//  ArtHaus
//
//  Created by Oleg Osin on 9/14/13.
//  Copyright (c) 2013 RelativeWave. All rights reserved.
//

precision highp float;
varying vec3 v_normal;
varying vec2 v_texCoord;
uniform vec3 u_color1;
uniform vec3 u_color2;
uniform float u_width;
uniform vec3 u_lightDirection;
uniform float u_time;

void main() {
    float time = sin(u_time) + 20.0;
    vec2 uv = vec2(cos(v_texCoord.x), cos(v_texCoord.y));
    
    mediump float modifier = cos(uv.x * time + uv.y * time);
    if (modifier < 0.0)
        modifier *= -1.0;
    modifier = clamp(modifier, 0.0, 1.0);
    
    float m = smoothstep(0.5 - u_width, 0.5 + u_width, modifier);
    vec3 Kd = mix(u_color1, u_color2, m);
    
    // Diffuse Lighting
    vec3 L = normalize(-u_lightDirection);
    vec3 N = normalize(v_normal);
    float NdotL = max(dot(N, L), 0.0);
    
	gl_FragColor = vec4(Kd * NdotL, 1.0);
}
