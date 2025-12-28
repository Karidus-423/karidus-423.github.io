precision mediump float;
uniform float uTime;
uniform vec2 uResolution;

float sdEquilateralTriangle( in vec2 p, in float r )
{
    const float k = sqrt(3.0);
    p.x = abs(p.x) - r;
    p.y = p.y + r/k;
    if( p.x+k*p.y>0.0 ) p = vec2(p.x-k*p.y,-k*p.x-p.y)/2.0;
    p.x -= clamp( p.x, -2.0*r, 0.0 );
    return -length(p)*sign(p.y);
}

void main() {
	vec2 uv = (gl_FragCoord.xy * 2.0 - uResolution.xy) / uResolution.y;
	vec3 bck_col = vec3(0.165, 0.184, 0.188);
	vec3 finalColor = vec3(0.0);

	float dist = sdEquilateralTriangle(uv, 0.8);

	dist = sin(dist * 8. + uTime)/8.;
	dist = step(0.1, dist);

	finalColor += bck_col * dist;

	gl_FragColor = vec4(finalColor, 0.0);
}
