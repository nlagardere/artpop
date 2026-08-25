//
//  APAuraSpriteViewShader.vsh
//  ARTPOP
//
//  Created by Max Weisel on 10/16/13.
//  Copyright (c) 2013 RelativeWave. All rights reserved.
//

attribute vec4 a_position;
attribute vec2 a_texCoord;
varying mediump vec2 v_texCoord;

void main() {
    gl_Position = u_modelviewProjectionMatrix * a_position;
    v_texCoord = a_texCoord;
}
