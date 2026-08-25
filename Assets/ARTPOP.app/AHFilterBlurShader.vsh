//
//  AHFilterBlurShader.vsh
//  ArtHaus
//
//  Created by Max Weisel & Chris Osborn on 10/28/13.
//  Copyright (c) 2013 RelativeWave. All rights reserved.
//

attribute vec4 a_position;
attribute vec2 a_texCoord;

uniform float u_texelWidthOffset;
uniform float u_texelHeightOffset;

varying vec2 v_centerTextureCoordinate;
varying vec2 v_oneStepLeftTextureCoordinate;
varying vec2 v_twoStepsLeftTextureCoordinate;
varying vec2 v_oneStepRightTextureCoordinate;
varying vec2 v_twoStepsRightTextureCoordinate;

void main() {
    gl_Position = u_modelviewProjectionMatrix * a_position;
    
    vec2 firstOffset = vec2(1.3846153846 * u_texelWidthOffset, 1.3846153846 * u_texelHeightOffset);
    vec2 secondOffset = vec2(3.2307692308 * u_texelWidthOffset, 3.2307692308 * u_texelHeightOffset);
    
    v_centerTextureCoordinate = a_texCoord;
    v_oneStepLeftTextureCoordinate = a_texCoord - firstOffset;
    v_twoStepsLeftTextureCoordinate = a_texCoord - secondOffset;
    v_oneStepRightTextureCoordinate = a_texCoord + firstOffset;
    v_twoStepsRightTextureCoordinate = a_texCoord + secondOffset;
}
