shader_type canvas_item;
uniform float alphaValue = 1.0;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	if (COLOR.g > (cos(TIME) + 1.0) / 4.0) {
		COLOR.r += sin(TIME / 1.2) / 5.0;
	}
	if (COLOR.a != 0.0)
		COLOR.a = alphaValue;
}
//void fragment() {
    //COLOR.rgb = vec3(1.0) - COLOR.rgb;
//}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
