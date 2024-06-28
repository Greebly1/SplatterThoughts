shader_type canvas_item;


//due to screen texture not supplying opacity
//the r channel will serve as the opacity/ink strength
uniform vec3 Albedo : source_color = vec3(0.0,0.0,0.0);
uniform float alpha : hint_range(0.0, 1.0, 0.1) = 1.0;

void fragment() {
	vec4 col = texture(TEXTURE, UV);
	
	float inkStrength = col.r;
	COLOR = vec4(Albedo, inkStrength * alpha);
	
}

