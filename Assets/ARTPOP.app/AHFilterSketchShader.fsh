//
//  AHFilterSketchShader.fsh
//  ArtHaus
//
//  Created by Max Weisel & Chris Osborn on 9/4/13.
//  Copyright (c) 2013 RelativeWave. All rights reserved.
//

varying highp vec2 v_texCoord;
uniform sampler2D u_sampler;

void main() {
    highp vec2 sampleDivisor = vec2(1.0 / 200.0, 1.0 / 320.0);
    //highp vec4 colorDivisor = vec4(colorDepth);
    
    highp vec2 samplePos = v_texCoord - mod(v_texCoord, sampleDivisor);
    highp vec4 color = texture2D(u_sampler, samplePos);
    
    //gl_FragColor = texture2D(inputImageTexture, samplePos );
    mediump vec4 colorCyan = vec4(85.0 / 255.0, 1.0, 1.0, 1.0);
    mediump vec4 colorMagenta = vec4(1.0, 85.0 / 255.0, 1.0, 1.0);
    mediump vec4 colorWhite = vec4(1.0, 1.0, 1.0, 1.0);
    mediump vec4 colorBlack = vec4(0.0, 0.0, 0.0, 1.0);
    
    mediump vec4 endColor;
    highp float blackDistance = distance(color, colorBlack);
    highp float whiteDistance = distance(color, colorWhite);
    highp float magentaDistance = distance(color, colorMagenta);
    highp float cyanDistance = distance(color, colorCyan);
    
    mediump vec4 finalColor;
    
    highp float colorDistance = min(magentaDistance, cyanDistance);
    colorDistance = min(colorDistance, whiteDistance);
    colorDistance = min(colorDistance, blackDistance);
    
    if (colorDistance == blackDistance) {
        finalColor = colorBlack;
    } else if (colorDistance == whiteDistance) {
        finalColor = colorWhite;
    } else if (colorDistance == cyanDistance) {
        finalColor = colorCyan;
    } else {
        finalColor = colorMagenta;
    }
    
    gl_FragColor = finalColor;
}
