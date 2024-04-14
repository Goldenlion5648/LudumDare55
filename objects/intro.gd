extends Node2D

@export var story_text: RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show_text()
	pass # Replace with function body.
	
func show_text():
	story_text.visible_ratio = 0
	while story_text.visible_ratio < 1:
		story_text.visible_characters += 1
		#if "\n" in story_text.text.substr(story_text.visible_characters, 3):
			#await get_tree().create_timer(1.0).timeout
		await get_tree().create_timer(0.03).timeout
		

func _input(event: InputEvent) -> void:
	if story_text.visible_ratio < 1:
		return
	if (event is InputEventKey or event is InputEventMouseButton) and event.pressed:
		Globals.reload_current_level()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
