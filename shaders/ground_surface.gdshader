shader_type spatial;
render_mode diffuse_burley, specular_schlick_ggx;

varying vec3 world_position;

float hash_2d(vec2 p) {
	return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453);
}

float value_noise(vec2 p) {
	vec2 i = floor(p);
	vec2 f = fract(p);
	f = f * f * (3.0 - 2.0 * f);

	float a = hash_2d(i);
	float b = hash_2d(i + vec2(1.0, 0.0));
	float c = hash_2d(i + vec2(0.0, 1.0));
	float d = hash_2d(i + vec2(1.0, 1.0));

	return mix(mix(a, b, f.x), mix(c, d, f.x), f.y);
}

void vertex() {
	world_position = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
}

void fragment() {
	vec2 ground_uv = world_position.xz;

	float broad_variation = value_noise(ground_uv * 0.16);
	float medium_variation = value_noise(ground_uv * 1.8);
	float fine_grain = hash_2d(floor(ground_uv * 24.0));

	float surface_noise = broad_variation * 0.48
		+ medium_variation * 0.34
		+ fine_grain * 0.18;

	vec3 asphalt_color = vec3(0.105, 0.12, 0.13);
	ALBEDO = asphalt_color * (0.78 + surface_noise * 0.34);
	ROUGHNESS = 0.94;
	METALLIC = 0.0;
	SPECULAR = 0.16;
}
