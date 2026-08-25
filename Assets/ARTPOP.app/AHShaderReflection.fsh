//
//  AHShaderReflection.fsh
//  ArtHaus
//
//  Created by Max Weisel on 9/4/13.
//  Copyright (c) 2013 RelativeWave. All rights reserved.
//

varying vec3 v_reflectDir;
uniform samplerCube u_sampler;
uniform vec4 u_tintColor;

float overlayf(float base, float blend) {
    if (base < 0.5) {
        return 2.0 * base * blend;
    } else {
        return 1.0 - 2.0 * (1.0 - base) * (1.0 - blend);
    }
}

vec3 overlay(vec3 base, vec3 blend) {
    return vec3(overlayf(base.r, blend.r),
                overlayf(base.g, blend.g),
                overlayf(base.b, blend.b));
}

void main() {
    vec4 baseColor = textureCube(u_sampler, v_reflectDir);
    vec3 overlayColor = overlay(baseColor.rgb, u_tintColor.rgb);
    gl_FragColor = vec4(mix(baseColor.rgb, overlayColor.rgb, u_tintColor.a), baseColor.a);
}
