//
//  AHEditorCreationFilterViewShader.fsh
//  ArtHaus
//
//  Created by Max Weisel & Chris Osborn on 9/4/13.
//  Copyright (c) 2013 RelativeWave. All rights reserved.
//

precision mediump float;
varying vec2 v_texCoord;
uniform sampler2D u_sampler;
uniform highp float u_exposure;

vec4 exposure(lowp vec4 color) {
    return vec4(color.rgb * pow(2.0, u_exposure), color.w);
}

void main() {
    gl_FragColor = exposure(texture2D(u_sampler, v_texCoord));
}
