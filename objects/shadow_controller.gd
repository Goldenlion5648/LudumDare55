extends Node2D
class_name ShadowController

var captured_objects = []
var walk_speed = 4

@export var player : CharacterBody2D
@export var starting_shadow_power = 500

var current_shadow_power = 0

var should_draw_shadow = false
var _debug = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	captured_objects.append(player)
	current_shadow_power = starting_shadow_power
	#Globals.captured_position_signal.connect(add_captured_point)
	Globals.captured_object_signal.connect(add_captured_object)
	#Globals.captured_walkable_signal.connect(add_captured_walkable)

func get_total_shadow_worth_of_captured_points():
	var ret = 0
	for object in captured_objects:
		if (object is CaptureableCharacter):
			ret += (object as CaptureableCharacter).shadow_worth
	return ret

func get_allotted_shadow_power():
	return starting_shadow_power + get_total_shadow_worth_of_captured_points()
	
#func add_captured_point(new_point):
	#points_to_go_through.append(new_point)

func add_captured_object(new_object):
	captured_objects.append(new_object)
	print_debug(captured_objects)
#
#func add_captured_object(new_object):
	#points_to_go_through.append(new_point)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	current_shadow_power = calculate_remaining_shadow_power()
	if Input.is_action_just_pressed("restart"):
		Globals.reload_current_level()
	
	if Input.is_action_just_pressed("stop_shadow_placing"):
		should_draw_shadow = not should_draw_shadow

func calculate_remaining_shadow_power():
	return get_allotted_shadow_power() - get_total_shadow_length(get_shadow_positions())
	
	

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
	for object in captured_objects:
		var current_capture_child = (object as Node2D).get_node("capturable") as CapturableComponent
		if current_capture_child != null:
			if current_capture_child.walkable:
				(object as Node2D).global_position += change
		if player.is_on_wall():
			break

func _input(event: InputEvent) -> void:
	if event is InputEventMouse:
		queue_redraw()

func get_objects_as_points():
	return captured_objects.map(func(x):return x.global_position)

func get_shadow_positions():
	var ret = get_objects_as_points()
	if not should_draw_shadow:
		return ret
	var mouse_to_last_point : Vector2 = get_global_mouse_position() - (ret[-1])
	var distance_vector: Vector2 = get_global_mouse_position() - (ret[-1])
	var total_len = get_total_shadow_length(ret)
	#prints("total_len", total_len)
	var remaining = get_allotted_shadow_power() - total_len
	#prints("remaining", remaining)
	distance_vector = distance_vector.limit_length((remaining))
	ret.append(ret[-1] + distance_vector)
	
	return ret

func get_total_shadow_length(points_to_calc_for) -> int:
	var dist_between = 0
	#var temp_positions = get_shadow_positions()
	for i in range(len(points_to_calc_for)-1):
		dist_between += (points_to_calc_for[i]).distance_to(points_to_calc_for[i+1])
	return dist_between
	

func _draw() -> void:
	var shadow_positions = get_shadow_positions()
	if _debug:
		print(shadow_positions)
	if len(shadow_positions) > 1:
		draw_polyline(shadow_positions, Color.BLACK, 20)
	#draw_polyline([Vector2(50, 100), Vector2(150, 100),Vector2(150, 100), Vector2(150, 200)], Color.BLACK, 10)
		
	#draw_line(%playerSprite.global_position, get_global_mouse_position(), Color.BLACK, 20)
