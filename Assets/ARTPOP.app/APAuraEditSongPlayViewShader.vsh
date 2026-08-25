//
//  AHShaderBlinnPhongTexture.vsh
//  ArtHaus
//
//  Created by Chris Osborn on 9/17/13.
//  Copyright (c) 2013 RelativeWave. All rights reserved.
//

precision highp float;
attribute vec4 a_position;
attribute vec2 a_texCoord;
varying vec2 v_texCoord;
varying vec3 v_eyeDir;
varying vec3 v_normalInterp;
uniform mat3 u_normalMatrix;
uniform mat3 u_rotationMatrix;

void main() {
    v_normalInterp = vec3((a_texCoord.x-0.5)*0.5, (a_texCoord.y-0.5)*0.5, 1.0);
    v_texCoord = a_texCoord;
    
    gl_Position = u_modelviewProjectionMatrix * a_position;
}
