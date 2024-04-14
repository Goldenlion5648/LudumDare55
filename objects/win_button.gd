extends Area2D

@export var node_to_remove: Node2D

func _ready() -> void:
	Globals.total_win_button_count += 1
	prints("total_win_button_count", Globals.total_win_button_count)

func _on_body_entered(body: Node2D) -> void:
	Globals.win_buttons_pressed += 1
	print("was entered")
	self.modulate = Color(0.7, 0.7, 0.7, 1)
	Globals.button_pressed_signal.emit()
	if Globals.win_buttons_pressed == Globals.total_win_button_count:
		node_to_remove.fade_kids()
		Globals.play_win_sound_signal.emit()
		await get_tree().create_timer(1.3).timeout
		Globals.start_win_sequence()

#func fade_out_node():
