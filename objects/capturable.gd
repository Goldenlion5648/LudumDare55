extends Area2D
class_name CapturableComponent

@export var shadow_worth = 100
@export var walkable = true
var is_captured = false

var mouse_is_inside = false

func _on_mouse_entered() -> void:
	print("mouse entered")
	mouse_is_inside = true

func try_capture():
	var temp_shadow_controller = (Globals.CURRENT_SHADOW_CONTROLLER)
	if is_captured or (temp_shadow_controller == null) or \
				not temp_shadow_controller.should_show_shadow_to_mouse() or\
				not temp_shadow_controller.allowed_to_capture():
		print("got blocked")
		return
	is_captured = true
	#Globals.captured_object_signal.emit(self.global_position)
	Globals.captured_object_signal.emit((self as Node2D).get_parent())
	#if walkable:
		#print("captured walkable")
func _on_mouse_exited() -> void:
	mouse_is_inside = false
	print("mouse exited")

func _input(event: InputEvent) -> void:
	if event is InputEventMouse and mouse_is_inside:
		print("had mouse")
		try_capture()


