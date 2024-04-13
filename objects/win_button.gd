extends Area2D

@export var node_to_remove: Node2D

func _on_body_entered(body: Node2D) -> void:
	print("was entered")
	node_to_remove.queue_free()
	await get_tree().create_timer(1.2).timeout
	Globals.start_win_sequence()
