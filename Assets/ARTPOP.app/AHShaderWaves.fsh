//
//  AHShaderWaves.fsh
//  ArtHaus
//
//  Created by Oleg Osin on 9/14/13.
//  Copyright (c) 2013 RelativeWave. All rights reserved.
//

precision mediump float;
varying vec2 v_texCoord;

uniform vec3 u_color1;
uniform vec3 u_color2;
uniform mediump float u_blockWidth;
uniform mediump float u_runningTime;

void main() {
	vec2 uv = v_texCoord;
	uv = -1.0 + 2.0 * uv;
	uv.y += 0.1;
    uv.y += sin(uv.x + u_runningTime);
    
    // NOTE: this can be a whole different shader
    //float fractOffset = fract(u_runningTime);
    //uv.y += fractOffset;  //(sin(uv.x + u_runningTime ));
    //uv.x += fractOffset;
    
    float blockWidth = abs(1.0 / (150.0 * uv.y));
	
	float c1 = mod(uv.x, 2.0 * blockWidth);
	c1 = step(u_blockWidth, c1);
	
	float c2 = mod(uv.y, 2.0 * blockWidth);
	c2 = step(u_blockWidth, c2);
	
	vec3 bg_color = mix(max(0.3, uv.x) * u_color1, max(0.3, uv.y) * u_color2, c1 * c2);
    
	// To create the waves
	//uv = -1.0 + 2.0 * uv;
	//uv.y += 0.1;
    //
    //float wave_width = 0.01;
	//vec3 wave_color = vec3(0.0);
	//for(float i = 0.0; i < 10.0; i++) {
	//	uv.y += (0.07 * sin(uv.x + i/7.0 + u_runningTime));
	//	wave_width = abs(1.0 / (150.0 * uv.y));
	//	wave_color += vec3(wave_width * 1.9, wave_width, wave_width * 1.5);
	//}
	//
	//vec3 final_color = bg_color + wave_color;
	
    gl_FragColor = vec4(bg_color, 1.0);
}
