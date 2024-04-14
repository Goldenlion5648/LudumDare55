extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.used_balloon.connect(update_text)
	
func update_text(new_count):
	self.text = "[center]%d[/center]" % new_count

