extends RichTextLabel

@export var shadow_controller: ShadowController
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.text = "[right]Shadow Power\n%d[/right]" % [shadow_controller.current_shadow_power]
