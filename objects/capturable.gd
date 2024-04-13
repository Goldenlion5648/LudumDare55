extends Area2D
class_name CapturableComponent

@export var shadow_worth = 100
@export var walkable = true
var is_captured = false

func _on_mouse_entered() -> void:
	print("mouse entered")
	var temp_shadow_controller = (Globals.CURRENT_SHADOW_CONTROLLER)
	if is_captured or (temp_shadow_controller == null) or \
				not temp_shadow_controller.shadow_ability_active() or\
				not temp_shadow_controller.allowed_to_capture():
		return
	is_captured = true
	#Globals.captured_object_signal.emit(self.global_position)
	Globals.captured_object_signal.emit((self as Node2D).get_parent())
	#if walkable:
		#print("captured walkable")
