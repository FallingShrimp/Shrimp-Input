shader_type canvas_item;
uniform vec4 color:source_color;
uniform float weight:hint_range(0.0, 1.0, 0.01);
void fragment() {
	float a=COLOR.a;
	COLOR=mix(COLOR,color,weight);
	COLOR.a=a;
}