extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func fade_kids():
	var full_fade_time = 0.8
	var current_fade_time = 0
	var step = 0.02
	while current_fade_time < full_fade_time:
		for child in get_children():
			var current_value = (child.get_node("laserSprite") as Node2D).material
			current_value.set_shader_parameter("alphaValue", full_fade_time - current_fade_time)
			#(child as Node2D).modulate = Color(current_value.r, 
										#current_value.g,
										#current_value.b, 
										#full_fade_time - current_fade_time)
		current_fade_time += step
		await get_tree().create_timer(step).timeout

