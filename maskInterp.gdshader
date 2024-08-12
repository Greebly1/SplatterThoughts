shader_type canvas_item;

uniform sampler2D SCREENTEX : hint_screen_texture;

void fragment() {
	vec4 col = texture(TEXTURE, UV);
	
	float maskStrength = col.g;
	float inkStrength = texture(SCREENTEX, SCREEN_UV).r;
	
	COLOR = vec4(inkStrength, maskStrength, 0.0 ,1.0);
	// Called for every pixel the material is visible on.
}