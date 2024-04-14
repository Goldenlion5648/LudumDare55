extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.selected_ability_changed.connect(update_text)

func update_text(_extra):
	var ability_name = ""
	if Globals.selected_ability == Globals.SelectableAbilities.NormalShadow:
		ability_name = "[font_size=45][outline_color=white][color=black]Summon Shadow[/color][/outline_color][/font_size]"
	elif Globals.selected_ability == Globals.SelectableAbilities.PlaceBalloon:
		ability_name = "[font_size=45][outline_color=white][color=darkred]Summon Balloon[/color][/outline_color][/font_size]"
	else:
		ability_name = "Summon Light"
	self.text = "[center]Right click to activate:\n%s\nHover on Icon For Info[/center]" % [ability_name]
	print('updated text')
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
