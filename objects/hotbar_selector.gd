extends Sprite2D

var is_scaling_out = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.selected_ability_changed.connect(change_parent)
	scale_in_out()


func change_parent(new_parent_button):
	reparent(new_parent_button, false)
	self.position = Vector2.ZERO + Vector2(50, 50)

func scale_in_out():
	var change_amount = 0.003
	while true:
		if is_scaling_out:
			if self.scale.x < .6:
				self.scale.x += change_amount
				self.scale.y += change_amount
			else:
				is_scaling_out = false
		else:
			if self.scale.x > .48:
				self.scale.x -= change_amount
				self.scale.y -= change_amount
			else:
				is_scaling_out = true
		await get_tree().create_timer(0.01).timeout
		
