extends Node2D
class_name ShadowController

var points_to_go_through = []
var objects_to_walk = []
var walk_speed = 4

@export var player : CharacterBody2D
@export var starting_shadow_power = 500

var current_shadow_power = 0

var should_draw_shadow = true
var _debug = false
#var points_to_go_through = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	objects_to_walk.append(player)
	current_shadow_power = starting_shadow_power
	Globals.captured_position_signal.connect(add_captured_point)
	Globals.captured_object_signal.connect(add_captured_point)
	Globals.captured_walkable_signal.connect(add_captured_walkable)

func add_captured_point(new_point):
	points_to_go_through.append(new_point)

func add_captured_walkable(new_object):
	objects_to_walk.append(new_object)
	print_debug(objects_to_walk)
#
#func add_captured_object(new_object):
	#points_to_go_through.append(new_point)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		Globals.reload_current_level()
	
	if Input.is_action_just_pressed("stop_shadow_placing"):
		should_draw_shadow = not should_draw_shadow
	calculate_shadow_power()

func calculate_shadow_power():
	current_shadow_power = get_total_shadow_length()
	for object in objects_to_walk:
		if (object is CaptureableCharacter):
			current_shadow_power += (object as CaptureableCharacter).shadow_worth

func _physics_process(delta: float) -> void:
	var change = Vector2(0,0)
	change += int(Input.is_action_pressed("walk_up")) * Vector2(0, -1)
	change += int(Input.is_action_pressed("walk_down")) * Vector2(0, 1)
	change += int(Input.is_action_pressed("walk_left")) * Vector2(-1, 0)
	change += int(Input.is_action_pressed("walk_right")) * Vector2(1, 0)
	change *= walk_speed
	if change:
		queue_redraw()
	var is_first = true
	for object in objects_to_walk:
		(object as Node2D).global_position += change
		if player.is_on_wall():
			break

func _input(event: InputEvent) -> void:
	if event is InputEventMouse:
		queue_redraw()

func get_shadow_positions():
	var ret = objects_to_walk.map(func(x):return x.global_position)
	if not should_draw_shadow:
		return ret
	var mouse_to_last_point : Vector2 = get_global_mouse_position() - (ret[-1])
	#FIX: CHANGE THIS CONSTANT and come back to this
	var limited = mouse_to_last_point.limit_length(200)
	#ret.append(get_global_mouse_position() + limited)
	ret.append(get_global_mouse_position())
	
	
	return ret

func get_total_shadow_length() -> int:
	var ret = starting_shadow_power
	var dist_between = 0
	var temp_positions = get_shadow_positions()
	for i in range(len(temp_positions)-1):
		dist_between += (temp_positions[i]).distance_to(temp_positions[i+1])
	ret -= dist_between
	return ret
	

func _draw() -> void:
	var shadow_positions = get_shadow_positions()
	if _debug:
		print(shadow_positions)
	if len(shadow_positions) > 1:
		draw_polyline(shadow_positions, Color.BLACK, 20)
	#draw_line(%playerSprite.global_position, get_global_mouse_position(), Color.BLACK, 20)
