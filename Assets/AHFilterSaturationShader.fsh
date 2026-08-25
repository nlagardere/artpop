//
//  AHFilterSaturationShader.fsh
//  ArtHaus
//
//  Created by Max Weisel & Chris Osborn on 9/4/13.
//  Copyright (c) 2013 RelativeWave. All rights reserved.
//

precision lowp float;

varying vec2 v_texCoord;

uniform sampler2D u_sampler;
uniform float u_saturation;
uniform float u_inversion;

// Values from "Graphics Shaders: Theory and Practice" by Bailey and Cunningham
const vec3 k_luminanceWeighting = vec3(0.2125, 0.7154, 0.0721);

vec4 saturate(vec4 color) {
    float luminance = dot(color.rgb, k_luminanceWeighting);
    vec3 gray = mix(vec3(luminance), vec3(1.0 - luminance), u_inversion);
    return vec4(mix(gray, color.rgb, u_saturation), color.w);
}

void main() {
    gl_FragColor = saturate(texture2D(u_sampler, v_texCoord));
}
