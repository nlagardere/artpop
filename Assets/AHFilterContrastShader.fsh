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
uniform lowp float u_contrast;

vec4 contrast(lowp vec4 color) {
    return vec4(((color.rgb - vec3(0.5)) * u_contrast + vec3(0.5)), color.w);
}

void main() {
    gl_FragColor = contrast(texture2D(u_sampler, v_texCoord));
}
