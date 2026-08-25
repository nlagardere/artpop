//
//  AHEditorCreationFilterViewShader.fsh
//  ArtHaus
//
//  Created by Max Weisel & Chris Osborn on 9/4/13.
//  Copyright (c) 2013 RelativeWave. All rights reserved.
//

precision lowp float;

varying vec2 v_texCoord;

uniform sampler2D u_sampler;
uniform sampler2D u_curve;

vec3 sampleCurve(vec3 color) {
    return vec3(texture2D(u_curve, vec2(color.r, 0.0)).r,
                texture2D(u_curve, vec2(color.g, 0.0)).g,
                texture2D(u_curve, vec2(color.b, 0.0)).b);
}

void main() {
    vec4 color = texture2D(u_sampler, v_texCoord);
    gl_FragColor = vec4(sampleCurve(color.rgb), color.a);
}
