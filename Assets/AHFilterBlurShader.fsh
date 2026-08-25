//
//  AHEditorCreationFilterViewShader.fsh
//  ArtHaus
//
//  Created by Chris Osborn on 10/28/13.
//  Copyright (c) 2013 RelativeWave. All rights reserved.
//

precision highp float;

uniform sampler2D u_sampler;

varying highp vec2 v_centerTextureCoordinate;
varying highp vec2 v_oneStepLeftTextureCoordinate;
varying highp vec2 v_twoStepsLeftTextureCoordinate;
varying highp vec2 v_oneStepRightTextureCoordinate;
varying highp vec2 v_twoStepsRightTextureCoordinate;

// const float weight[3] = float[]( 0.2270270270, 0.3162162162, 0.0702702703 );

void main() {
    lowp vec4 fragmentColor = texture2D(u_sampler, v_centerTextureCoordinate) * 0.2270270270;
    fragmentColor += texture2D(u_sampler, v_oneStepLeftTextureCoordinate) * 0.3162162162;
    fragmentColor += texture2D(u_sampler, v_oneStepRightTextureCoordinate) * 0.3162162162;
    fragmentColor += texture2D(u_sampler, v_twoStepsLeftTextureCoordinate) * 0.0702702703;
    fragmentColor += texture2D(u_sampler, v_twoStepsRightTextureCoordinate) * 0.0702702703;
    
    gl_FragColor = fragmentColor;
}
