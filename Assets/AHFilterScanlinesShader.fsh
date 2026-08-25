//
//  AHFilterScanlinesShader.fsh
//  ArtHaus
//
//  Created by Chris Osborn on 10/28/13.
//  Copyright (c) 2013 RelativeWave. All rights reserved.
//

precision highp float;

varying vec2 v_texCoord;

uniform sampler2D u_sampler;
uniform float u_runningTime;
uniform float u_height;

void main() {
    float posY = v_texCoord.y * u_height * 1.3;
    float lineIntesity = sin(posY) * 0.35;
    
    float scanT = abs(sin(u_runningTime));
    if (floor(scanT*1500.0) > floor(posY) && floor(scanT*1500.0) < floor(posY)+50.0) {
        lineIntesity += scanT * 0.8;
    }
    
    vec4 color = texture2D(u_sampler, v_texCoord);
    gl_FragColor = vec4(color.rgb + lineIntesity, color.a);
}
