shader_type canvas_item;

float invert(float input) {
	return input * -1.0 + 1.0;
}

void fragment() {
	vec4 base_tex = texture(TEXTURE, UV);
	
	float previewer = invert(base_tex.a);
	
	COLOR = vec4(base_tex.a, base_tex.a, base_tex.a, 1.0);
	COLOR = vec4(previewer, previewer, previewer, 1.0);
}
