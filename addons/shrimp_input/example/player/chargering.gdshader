shader_type canvas_item;
uniform float angle:hint_range(0.0, 1, 0.01)=0;
void fragment() {
	float d=distance(UV,vec2(0.5,0.5));
	vec2 arr=vec2(0.5,0.5)-UV;
	COLOR.a*=float(0.45<=d&&d<=0.5&&acos(dot(arr,vec2(0,-1))/length(arr))<angle*PI);;
}