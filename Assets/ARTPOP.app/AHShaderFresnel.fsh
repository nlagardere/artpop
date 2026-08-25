//
//  AHShaderFresnel.fsh
//  ArtHaus
//
//  Created by Chris Osborn on 9/12/13.
//  Copyright (c) 2013 RelativeWave. All rights reserved.
//

varying vec3 v_refractDir;
varying vec3 v_reflectDir;
varying float v_fresnel;
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
	vec4 refractionColor = textureCube(u_sampler, normalize(v_refractDir));
	vec4 reflectionColor = textureCube(u_sampler, normalize(v_reflectDir));
    
    vec4 baseColor = mix(refractionColor, reflectionColor, v_fresnel);
    vec3 overlayColor = overlay(baseColor.rgb, u_tintColor.rgb);
    gl_FragColor = vec4(mix(baseColor.rgb, overlayColor.rgb, u_tintColor.a), baseColor.a);
}
