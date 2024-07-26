shader_type canvas_item;

varying vec2 WorldPosition;
uniform float density : hint_range(10.0, 500.0, 0.1)= 100.0;
uniform float innerradius : hint_range(0.0, 1.0, 0.01) = 0.08;
uniform float outerradiuss : hint_range(0.0, 1.0, 0.01) = 0.1; 
uniform vec3 albedo : source_color = vec3(1.0,1.0,1.0);
uniform vec2 translation = vec2(0.0, 0.0);
uniform float translationScalar : hint_range(0.0, 25.0, 0.1) = 1.0;

void vertex() {
	WorldPosition = (MODEL_MATRIX * vec4(VERTEX + (translation*translationScalar), 0.0, 1.0)).xy;
}

void fragment() {
	float dist = length((fract(WorldPosition/density)-0.5)*2.0);
	dist *= 1.0;
	
	dist = smoothstep(outerradiuss, innerradius, dist);
	
	COLOR = vec4(albedo, dist);
	
}
