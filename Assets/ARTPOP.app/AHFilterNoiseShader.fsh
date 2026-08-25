//
//  AHFilterNoiseShader.fsh
//  ArtHaus
//
//  Created by Chris Osborn on 10/28/13.
//  Copyright (c) 2013 RelativeWave. All rights reserved.
//

precision highp float;
varying lowp vec2 v_texCoord;
uniform lowp sampler2D u_sampler;
uniform highp float u_time;
uniform lowp float u_blend;

float rand(vec2 xy) {
    return fract(sin(dot(xy.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

void main() {
    vec2 noiseXY = vec2(v_texCoord.x + u_time, v_texCoord.y + u_time);
    vec3 noise = vec3(rand(noiseXY));
    
    vec4 color = texture2D(u_sampler, v_texCoord);
    color.rgb =  mix(color.rgb, noise, u_blend);
    
    gl_FragColor = color;
}
