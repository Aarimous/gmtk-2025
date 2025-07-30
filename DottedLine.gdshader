shader_type canvas_item;

uniform vec4 outline_color : source_color = vec4(1.0);

void fragment(){
	vec2 moving_uv = vec2(UV.x + TIME *.2, UV.y);
	vec4 in_tex = texture(TEXTURE, moving_uv);
	COLOR = vec4(outline_color.r, outline_color.g, outline_color.b, in_tex.a * outline_color.a);
	}