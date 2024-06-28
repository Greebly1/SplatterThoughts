shader_type canvas_item;

uniform sampler2D inputImage;
uniform sampler2D fractalNoise;
uniform float power : hint_range(0.0, 0.5, 0.001) = 0.05f;

const vec2 UP = vec2(0.0, 1.0);
const vec2 DOWN = vec2(0.0, -1.0);
const vec2 LEFT = vec2(-1.0, 0.0);
const vec2 RIGHT = vec2(1.0, 0.0);

float desaturate(vec3 Color) {
	return ( Color.r + Color.g + Color.b ) / 3.0;
}

vec3 displace(float amount, vec2 direction, sampler2D image, vec2 coords, float noise) {
	vec2 offset = direction * amount * ((noise * 2.0)-1.0);
	return texture(image, coords + offset).rgb;
}

float darken(float a, float b) {
	return min(a, b);
}

void fragment() {
	vec3 tex = texture(inputImage, UV).rgb;
	float noise = texture(fractalNoise, UV).r;
	vec2 offset = vec2(0.0, 0.05) * ((texture(fractalNoise, UV).r * 2.0) - 1.0);
	vec3 offsetTex = texture(inputImage, UV + offset).rgb;
	
	float desat = desaturate(tex);
	desat = darken(desat, desaturate(displace(power/50.0, UP, inputImage, UV, noise)));
	desat = darken(desat, desaturate(displace(power/50.0, DOWN, inputImage, UV, noise)));
	desat = darken(desat, desaturate(displace(power/50.0, LEFT, inputImage, UV, noise)));
	desat = darken(desat, desaturate(displace(power/50.0, RIGHT, inputImage, UV, noise)));
	
	vec3 fin = vec3(desat, desat, desat);
	// Called for every pixel the material is visible on.
	COLOR = vec4(desat* 0.4,0.0,0.0, 1.0); //r -> ink strength
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
