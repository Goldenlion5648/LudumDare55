extends HBoxContainer

@export var shadow_icon: TextureButton
@export var balloons_icon: TextureButton
@export var lights_icon: TextureButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.SHADOW_ICON = shadow_icon
	Globals.BALLOON_ICON = balloons_icon
	Globals.LIGHT_ICON = lights_icon
	print('set icons')
	Globals.icons_setup.emit()
	

#func change_selector_parent():
	#
#func change_selector_parent(new_parent_button):
	#reparent(new_parent_button, false)
	#self.position = Vector2.ZERO + Vector2(50, 50)
#
#
#func hide_icons(newly_selected_ability):
	#if newly_selected_ability
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


func _on_shadow_icon_pressed() -> void:
	Globals.selected_ability = Globals.SelectableAbilities.NormalShadow
	Globals.selected_ability_changed.emit(Globals.SHADOW_ICON)
	Globals.SHADOW_ICON.hide()
	Globals.SHADOW_ICON.show()
	

func _on_balloon_icon_pressed() -> void:
	Globals.selected_ability = Globals.SelectableAbilities.PlaceBalloon
	Globals.selected_ability_changed.emit(Globals.BALLOON_ICON)
	Globals.BALLOON_ICON.hide()
	Globals.BALLOON_ICON.show()

func _on_light_icon_pressed() -> void:
	Globals.selected_ability = Globals.SelectableAbilities.ThrowLight
	Globals.selected_ability_changed.emit(Globals.LIGHT_ICON)
	Globals.LIGHT_ICON.hide()
	Globals.LIGHT_ICON.show()
