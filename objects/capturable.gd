extends Area2D

@export var walkable = true
var is_captured = false

func _on_mouse_entered() -> void:
	print("mouse entered")
	if is_captured:
		return
	is_captured = true
	Globals.captured_position_signal.emit(self.global_position)
	if walkable:
		Globals.captured_walkable_signal.emit((self as Node2D).get_parent())
		print("captured walkable")
		
