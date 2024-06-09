shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform sampler2D displaceNoise;
uniform float power : hint_range(0.0, 0.5, 0.01) = 0.05f;

const vec2 UP = vec2(0.0, 1.0);
const vec2 DOWN = vec2(0.0, -1.0);
const vec2 LEFT = vec2(-1.0, 0.0);
const vec2 RIGHT = vec2(1.0, 0.0);

vec3 displace(float amount, vec2 direction, sampler2D image, vec2 coords, float noise) {
	vec2 offset = direction * amount * ((noise * 2.0)-1.0);
	return texture(image, coords + offset).rgb;
}

float desaturate(vec3 Color) {
	return ( Color.r + Color.g + Color.b ) / 3.0;
}

vec3 darken(vec3 a, vec3 b) {
	if (desaturate(a) > desaturate(b)) {
		return b;
	} else {
		return a;
	}
}

vec3 lighten(vec3 a, vec3 b) {
		if (desaturate(a) < desaturate(b)) {
		return b;
	} else {
		return a;
	}
}

void fragment() {
	float noise = texture(displaceNoise, UV).r;
	
	vec3 finColor = texture(SCREEN_TEXTURE, SCREEN_UV).rgb;
	finColor = lighten(finColor, displace(power, UP, SCREEN_TEXTURE, SCREEN_UV, noise));
	finColor = lighten(finColor, displace(power, DOWN, SCREEN_TEXTURE, SCREEN_UV, noise));
	finColor = lighten(finColor, displace(power, LEFT, SCREEN_TEXTURE, SCREEN_UV, noise));
	finColor = lighten(finColor, displace(power, RIGHT, SCREEN_TEXTURE, SCREEN_UV, noise));
	
	COLOR = vec4(finColor, 1.0);
}