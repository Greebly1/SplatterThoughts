shader_type canvas_item;

uniform sampler2D SCREENTEX : hint_screen_texture;

void fragment() {
	vec4 col = texture(TEXTURE, UV);
	
	float underlyingInkStrength = texture(SCREENTEX, SCREEN_UV).g;
	float inkStrength = col.g;
	
	COLOR = vec4(0.0, max(underlyingInkStrength, inkStrength), 0.0, max(underlyingInkStrength, inkStrength));
}
