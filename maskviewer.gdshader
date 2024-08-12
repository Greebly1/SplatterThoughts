shader_type canvas_item;

void fragment() {
	vec4 img = texture(TEXTURE, UV);
	
	COLOR = vec4(1.0, 0.5, 0.0, img.g);
	// Called for every pixel the material is visible on.
}
