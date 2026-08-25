//
//  AHFilterOverlayTextureShader.fsh
//  ArtHaus
//
//  Created by Chris Osborn on 12/11/13.
//  Copyright (c) 2013 RelativeWave. All rights reserved.
//

precision mediump float;
varying vec2 v_texCoord;
uniform sampler2D u_sampler;
uniform sampler2D u_overlay;

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
    vec4 textureColor = texture2D(u_sampler, v_texCoord);
    vec4 overlayColor = texture2D(u_overlay, v_texCoord);
    gl_FragColor = vec4(overlay(textureColor.rgb, overlayColor.rgb), 1.0);
}
