//
//  APMenuHeatMapGlobeShader.vsh
//  ARTPOP
//
//  Created by Oleg Osin on 10/22/13.
//  Copyright (c) 2013 RelativeWave. All rights reserved.
//

attribute highp vec4 a_position;
attribute lowp vec3 a_normal;
attribute vec2 a_texCoord;

uniform mat3 u_normalMatrix;
uniform vec3 u_rotation;

varying vec3 v_normalInterp;
varying mediump vec2 v_texCoord;

void main() {
    v_normalInterp = u_normalMatrix * a_normal;
    
    v_texCoord = a_texCoord;
    
    gl_Position = u_modelviewProjectionMatrix * a_position;
}
