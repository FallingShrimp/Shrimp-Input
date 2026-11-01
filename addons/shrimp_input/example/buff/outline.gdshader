shader_type canvas_item;
uniform vec4 line_color:source_color;
void fragment(){
	COLOR*=line_color;
}