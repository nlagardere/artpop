//
//  AHFilterPixelateShader.fsh
//  ArtHaus
//
//  Created by Max Weisel & Chris Osborn on 9/4/13.
//  Copyright (c) 2013 RelativeWave. All rights reserved.
//

precision mediump float;

varying vec2 v_texCoord;

uniform sampler2D u_sampler;
uniform float u_aspectRatio;
uniform lowp float u_fractionalWidthOfAPixel;
uniform lowp float u_inversion;

vec4 pixelate() {
    if (u_fractionalWidthOfAPixel > 0.0) {
        vec2 divisor = vec2(u_fractionalWidthOfAPixel, u_fractionalWidthOfAPixel);
        if (u_aspectRatio < 1.0) {
            divisor.y *= u_aspectRatio;
        } else {
            divisor.y /= u_aspectRatio;
        }
        return texture2D(u_sampler, v_texCoord - mod(v_texCoord, divisor) + 0.5*divisor);
    } else {
        return texture2D(u_sampler, v_texCoord);
    }
}

void main() {
    vec4 color = pixelate();
    gl_FragColor = mix(color, 1.0 - color, u_inversion);
}
