extends Area2D
class_name CapturableComponent

@export var walkable = true
var is_captured = false

func _on_mouse_entered() -> void:
	print("mouse entered")
	if is_captured:
		return
	is_captured = true
	#Globals.captured_object_signal.emit(self.global_position)
	Globals.captured_object_signal.emit((self as Node2D).get_parent())
	#if walkable:
		#print("captured walkable")
		
