extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.selected_ability_changed.connect(change_parent)


func change_parent(new_parent_button):
	reparent(new_parent_button, false)
	self.position = Vector2.ZERO + Vector2(50, 50)

func scale_in_out():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
