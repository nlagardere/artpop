//
//  AHShaderDiffuse.fsh
//  ArtHaus
//
//  Created by Max Weisel on 9/4/13.
//  Copyright (c) 2013 RelativeWave. All rights reserved.
//

precision lowp float;
uniform vec4 u_color;

void main() {
    gl_FragColor = u_color;
}
