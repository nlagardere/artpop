//
//  AHShaderNormalMap.fsh
//  ArtHaus
//
//  Created by Chris Osborn on 9/17/13.
//  Copyright (c) 2013 RelativeWave. All rights reserved.
//

precision highp float;

varying vec2 v_texCoord;
varying vec3 v_viewDirection;
varying vec3 v_lightDirection;
varying vec3 v_halfDirection;

uniform sampler2D u_sampler;
uniform sampler2D u_normalMapSampler;
uniform vec3 u_colorAmbient;
uniform vec4 u_colorTint;
uniform vec3 u_colorSpecular;
uniform vec3 u_colorEmissive;
uniform float u_alpha;
uniform float u_shininess;

float overlayf(float base, float blend) {
    if (base < 0.5) {
        return 2.0 * base * blend;
    } else {
        return 1.0 - 2.0 * (1.0 - base) * (1.0 - blend);
    }
}

vec3 overlay(vec3 base, vec3 blend) {
    return vec3(overlayf(base.r, blend.r),
                overlayf(base.g, blend.g),
                overlayf(base.b, blend.b));
}

void main() {
    vec3 N = normalize(texture2D(u_normalMapSampler, v_texCoord).xyz * 2.0 - 1.0);
    vec3 L = normalize(v_lightDirection);
    vec3 H = normalize(v_halfDirection);
    
    float NdotL = max(dot(N, L), 0.0);
    float NdotH = max(dot(N, H), 0.0);
    
    vec3 Ka = u_colorAmbient;
    
    vec4 textureColor = texture2D(u_sampler, v_texCoord);
    vec3 overlayColor = overlay(textureColor.rgb, u_colorTint.rgb);
    vec3 Kd = mix(textureColor.rgb, overlayColor.rgb, u_colorTint.a) * NdotL;
    
    vec3 Ks = u_colorSpecular * pow(NdotH, u_shininess);
    
    vec3 Ke = u_colorEmissive;
    
    gl_FragColor = vec4(Ka + Kd + Ks + Ke, u_alpha);
}
