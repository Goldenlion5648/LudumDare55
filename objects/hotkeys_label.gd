extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Globals.current_level != 2:
		self.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
