extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.selected_ability_changed.connect(update_text)

func update_text(_extra):
	var ability_name = ""
	if Globals.selected_ability == Globals.SelectableAbilities.NormalShadow:
		ability_name = "Summon Shadow"
	elif Globals.selected_ability == Globals.SelectableAbilities.PlaceBalloon:
		ability_name = "Summon Shade"
	else:
		ability_name = "Summon Light"
	self.text = "[center]Right click to activate:\n%s[/center]" % [ability_name]
	print('updated text')
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
