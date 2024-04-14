extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.selected_ability_changed.connect(update_text)

func update_text(_extra):
	var ability_name = ""
	var description = ""
	if Globals.selected_ability == Globals.SelectableAbilities.NormalShadow:
		ability_name = "[font_size=45][outline_color=white][color=black]Summon Shadow[/color][/outline_color][/font_size]"
		description = "Extends shadow from furthest\nconnected point."
	elif Globals.selected_ability == Globals.SelectableAbilities.PlaceBalloon:
		ability_name = "[font_size=45][outline_color=white][color=darkred]Summon Balloon[/color][/outline_color][/font_size]"
		description = "Places a balloon that\nextends the shadows reach."
	else:
		ability_name = "Summon Light"
	self.text = "[center]Right click to activate:\n%s\n%s[/center]" % [ability_name, description]
	print('updated text')
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
