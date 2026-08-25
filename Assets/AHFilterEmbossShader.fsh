//
//  AHFilterEmbossShader.fsh
//  ArtHaus
//
//  Created by Chris Osborn on 12/11/13.
//  Copyright (c) 2013 RelativeWave. All rights reserved.
//

#ifdef GL_ES
precision mediump float;
#endif

varying vec2 v_texCoord;

uniform sampler2D u_texture;
uniform vec2 u_resolution;

void main() {
    vec2 onePixel = vec2(1.0 / u_resolution.x, 1.0 / u_resolution.y);
    
    vec2 texCoord = v_texCoord;
    
    vec4 color;
    color.rgb = vec3(0.5);
    color -= texture2D(u_texture, texCoord - onePixel) * 5.0;
    color += texture2D(u_texture, texCoord + onePixel) * 5.0;
    color.rgb = vec3((color.r + color.g + color.b) / 3.0);
    
    gl_FragColor = vec4(color.rgb, 1);
}
