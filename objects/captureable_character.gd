extends CharacterBody2D
class_name CaptureableCharacter

@export var shadow_worth = 100

func _physics_process(delta: float) -> void:
	move_and_slide()
