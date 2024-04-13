extends Area2D


func _on_mouse_entered() -> void:
	print("mouse entered")
	Globals.captured_position_signal.emit(self.global_position)
