//
//  APAuraSpriteViewShader.fsh
//  ARTPOP
//
//  Created by Max Weisel on 10/16/13.
//  Copyright (c) 2013 RelativeWave. All rights reserved.
//

precision lowp float;
varying vec2 v_texCoord;
uniform sampler2D u_sampler;
uniform sampler2D u_sampler2;
uniform float u_mix;

void main() {
    gl_FragColor = mix(texture2D(u_sampler, v_texCoord), texture2D(u_sampler2, v_texCoord), u_mix);
}
