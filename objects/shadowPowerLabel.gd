extends RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var number = Globals.CURRENT_SHADOW_CONTROLLER.get_shadow_power_to_display()
	if number <= 1:
		self.text = "[right]Shadow Length\nRemaining\n[color=red]%d[/color][/right]" % [number]
	else:
		self.text = "[right]Shadow Length\nRemaining\n%d[/right]" % [number]
		
