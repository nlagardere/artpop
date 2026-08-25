//
//  AHFilterVignetteShader.fsh
//  ArtHaus
//
//  Created by Max Weisel & Chris Osborn on 9/4/13.
//  Copyright (c) 2013 RelativeWave. All rights reserved.
//

precision mediump float;
varying lowp vec2 v_texCoord;
uniform lowp sampler2D u_sampler;
uniform lowp vec2 u_vignetteCenter;
uniform lowp vec3 u_vignetteColor;
uniform lowp float u_vignetteStart;
uniform lowp float u_vignetteEnd;
uniform highp vec2 u_resolution;

vec4 vignette(lowp vec4 color) {
    
    // Scale out texture coordiantes so we get a perfect circle
    mediump vec2 texCoord = v_texCoord;
    if (u_resolution.x < u_resolution.y) {
        texCoord.y = (texCoord.y - 0.5) * (u_resolution.y / u_resolution.x) + 0.5;
    } else if (u_resolution.x > u_resolution.y) {
        texCoord.x = (texCoord.x - 0.5) * (u_resolution.x / u_resolution.y) + 0.5;
    }
    
    mediump float d = distance(texCoord, vec2(u_vignetteCenter.x, u_vignetteCenter.y));
    lowp float percent = smoothstep(u_vignetteStart, u_vignetteEnd, d);
    return vec4(mix(color.rgb, u_vignetteColor, percent), color.a);
}

void main() {
    gl_FragColor = vignette(texture2D(u_sampler, v_texCoord));
}
