//
//  AHShaderDiffuseTexture.fsh
//  ArtHaus
//
//  Created by Chris Osborn on 10/7/13.
//  Copyright (c) 2013 RelativeWave. All rights reserved.
//

precision lowp float;
varying vec2 v_texCoord;
uniform sampler2D u_sampler;
uniform vec3 u_colorAmbient;
uniform vec4 u_colorTint;
uniform float u_alpha;

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
    vec3 Ka = u_colorAmbient;
    
    vec4 textureColor = texture2D(u_sampler, v_texCoord);
    vec3 overlayColor = overlay(textureColor.rgb, u_colorTint.rgb);
    vec3 Kd = mix(textureColor.rgb, overlayColor.rgb, u_colorTint.a);
    
    gl_FragColor = vec4(Ka + Kd, u_alpha);
}
