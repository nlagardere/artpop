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
uniform lowp float u_hazeDistance;
uniform highp float u_hazeSlope;

vec4 haze(lowp vec4 color) {
    highp vec4 c = vec4(1.0);
    highp float  d = v_texCoord.y * u_hazeSlope + u_hazeDistance;
    return (color - d * c) / (1.0 - d);
}

void main() {
    gl_FragColor = haze(texture2D(u_sampler, v_texCoord));
}
