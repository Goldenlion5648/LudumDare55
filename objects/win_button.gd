extends Area2D

@export var node_to_remove: Node2D

func _on_body_entered(body: Node2D) -> void:
	print("was entered")
	node_to_remove.fade_kids()
	Globals.play_win_sound_signal.emit()
	await get_tree().create_timer(1.3).timeout
	Globals.start_win_sequence()

#func fade_out_node():
