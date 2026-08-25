//
//  AHEditorCreationFilterViewShader.fsh
//  ArtHaus
//
//  Created by Max Weisel & Chris Osborn on 9/4/13.
//  Copyright (c) 2013 RelativeWave. All rights reserved.
//

precision mediump float;
varying vec2 v_texCoord;
uniform sampler2D u_sampler;
uniform highp float u_aspectRatio;
uniform highp float u_exposure;
uniform lowp float u_contrast;
uniform lowp float u_saturation;
uniform lowp vec2 u_vignetteCenter;
uniform lowp vec3 u_vignetteColor;
uniform lowp float u_vignetteStart;
uniform lowp float u_vignetteEnd;
uniform lowp float u_hazeDistance;
uniform highp float u_hazeSlope;
uniform highp float u_pixellateFractionalWidthOfAPixel;

// Values from "Graphics Shaders: Theory and Practice" by Bailey and Cunningham
const mediump vec3 luminanceWeighting = vec3(0.2125, 0.7154, 0.0721);

vec4 exposure(lowp vec4 color) {
    return vec4(color.rgb * pow(2.0, u_exposure), color.w);
}

vec4 saturate(lowp vec4 color) {
    lowp float luminance = dot(color.rgb, luminanceWeighting);
    lowp vec3 greyScaleColor = vec3(luminance);
	return vec4(mix(greyScaleColor, color.rgb, u_saturation), color.w);
}

vec4 contrast(lowp vec4 color) {
    return vec4(((color.rgb - vec3(0.5)) * u_contrast + vec3(0.5)), color.w);
}

vec4 vignette(lowp vec4 color) {
    lowp float d = distance(v_texCoord, vec2(u_vignetteCenter.x, u_vignetteCenter.y));
    lowp float percent = smoothstep(u_vignetteStart, u_vignetteEnd, d);
    return vec4(mix(color.rgb, u_vignetteColor, percent), color.a);
}

vec4 haze(lowp vec4 color) {
    highp vec4 c = vec4(1.0);
    highp float  d = v_texCoord.y * u_hazeSlope + u_hazeDistance;
    return (color - d * c) / (1.0 - d);
}

vec4 pixellate() {
    if (u_pixellateFractionalWidthOfAPixel > 0.0) {
        highp vec2 sampleDivisor = vec2(u_pixellateFractionalWidthOfAPixel, u_pixellateFractionalWidthOfAPixel / u_aspectRatio);
        highp vec2 samplePos = v_texCoord - mod(v_texCoord, sampleDivisor) + 0.5 * sampleDivisor;
        return texture2D(u_sampler, samplePos);
    } else {
        return texture2D(u_sampler, v_texCoord);
    }
}

void main() {
    vec4 color = pixellate();
    color = exposure(color);
    color = saturate(color);
    color = contrast(color);
    color = vignette(color);
    color = haze(color);
    gl_FragColor = color;
}
