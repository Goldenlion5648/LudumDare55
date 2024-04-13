extends Node2D


var points_to_go_through = []
#var points_to_go_through = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	Globals.captured_position_signal.connect(add_captured_point)
	Globals.captured_object_signal.connect(add_captured_point)

func add_captured_point(new_point):
	points_to_go_through.append(new_point)
#
#func add_captured_object(new_object):
	#points_to_go_through.append(new_point)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouse:
		queue_redraw()
		

func _draw() -> void:
	var temp_points = [%playerSprite.global_position] + points_to_go_through + [get_global_mouse_position()]
	draw_polyline(temp_points, Color.BLACK, 20)
	#draw_line(%playerSprite.global_position, get_global_mouse_position(), Color.BLACK, 20)
