extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Globals.current_level != 2:
		self.hide()

