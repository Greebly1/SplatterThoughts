shader_type canvas_item;



uniform sampler2D SCREENTEX : hint_screen_texture;
uniform float opacity : hint_range(0.0, 1.0, 0.01) = 1.0;

void fragment() {
	vec4 col = texture(TEXTURE, UV);
	
	float underlyingInkStrength = texture(SCREENTEX, SCREEN_UV).r;
	float inkStrength = col.r;
	//due to screen texture not supplying opacity
	//the r channel will serve as the opacity/ink strength
	COLOR = vec4(max(underlyingInkStrength, inkStrength), 0.0, 0.0, max(underlyingInkStrength, inkStrength) * opacity);
	
}