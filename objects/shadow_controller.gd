extends Node2D
class_name ShadowController

var captured_objects = []
var walk_speed = 300
var old_mouse_positions = []

@export var player : CharacterBody2D
@export var starting_shadow_power = 500
@export var balloons_allowed = 0
@export var lights_allowed = 0

var balloons_used = 0
var lights_used = 0
var farthest_shadow_stretched = 0

const balloon_default_instance = preload("res://objects/balloon.tscn")

var current_shadow_power = 0

var has_active_shadow = false
var _debug = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.CURRENT_SHADOW_CONTROLLER = self
	Globals.total_win_button_count = 0
	Globals.win_buttons_pressed = 0
	setup_captured_objects()
	current_shadow_power = starting_shadow_power
	#Globals.captured_position_signal.connect(add_captured_point)
	Globals.captured_object_signal.connect(add_captured_object)
	# await get_tree().create_timer(0.2).timeout
	Globals.icons_setup.connect(hide_unavailable_icons)
	Globals.selected_ability = Globals.SelectableAbilities.NormalShadow
	Globals.selected_ability_changed.emit(Globals.SHADOW_ICON)
# 	track_mouse_positions()


# func track_mouse_positions():
# 	while true:
# 		old_mouse_positions.append(get_global_mouse_position())
# 		if len(old_mouse_positions) > 10:
# 			old_mouse_positions.pop_front()
# 		queue_redraw()
# 		await get_tree().create_timer(0.02).timeout
	#Globals.captured_walkable_signal.connect(add_captured_walkable)

func get_total_shadow_worth_of_captured_points():
	var ret = 0
	for object in captured_objects:
		var captureable_part = object.get_node("capturable")
		if captureable_part != null:
			ret += captureable_part.shadow_worth
	return ret

func get_allotted_shadow_power():
	# prints("starting_shadow_power", starting_shadow_power)
	return starting_shadow_power + get_total_shadow_worth_of_captured_points()
	
func hide_unavailable_icons():
	if balloons_allowed == 0 and Globals.BALLOON_ICON != null:
		Globals.BALLOON_ICON.hide()
	if lights_allowed == 0 and Globals.LIGHT_ICON != null:
		Globals.LIGHT_ICON.hide()
	Globals.selected_ability_changed.emit(Globals.SHADOW_ICON)

#func add_captured_point(new_point):
	#points_to_go_through.append(new_point)

func add_captured_object(new_object):
	captured_objects.append(new_object)
	# print_debug(captured_objects)
#
#func add_captured_object(new_object):
	#points_to_go_through.append(new_point)
	
func setup_captured_objects():
	for object in captured_objects:
		object.get_node("capturable").is_captured = false
	if len(captured_objects) > 1:
		Globals.retrack_shadows_signal.emit()
	captured_objects = [player]
	player.get_node("capturable").is_captured = true
	queue_redraw()

func should_show_shadow_to_mouse():
	return Globals.selected_ability == Globals.SelectableAbilities.NormalShadow and has_active_shadow
	
func allowed_to_capture():
	return get_shadow_power_to_display() > 1

func place_balloon():
	if balloons_used >= balloons_allowed:
		return
	balloons_used += 1
	Globals.used_balloon_ability.emit(balloons_allowed - balloons_used)
	var new_instance = balloon_default_instance.instantiate()
	new_instance.global_position = get_global_mouse_position()
	add_child(new_instance)

func activate_selected_ability():
	match Globals.selected_ability:
		Globals.SelectableAbilities.NormalShadow:
			has_active_shadow = not has_active_shadow
			if has_active_shadow:
				Globals.used_shadow_ability.emit()
		Globals.SelectableAbilities.PlaceBalloon:
			place_balloon()
		Globals.SelectableAbilities.ThrowLight:
			pass
			

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	current_shadow_power = calculate_remaining_shadow_power()
	if Input.is_action_just_pressed("restart"):
		Globals.reload_current_level()
	if Input.is_action_just_pressed("clear_shadows"):
		setup_captured_objects()
		
	if Input.is_action_just_pressed("select_shadow"):
		Globals.selected_ability = Globals.SelectableAbilities.NormalShadow
		Globals.selected_ability_changed.emit(Globals.SHADOW_ICON)
	if Input.is_action_just_pressed("select_balloon") and balloons_allowed > 0:
		has_active_shadow = false
		Globals.selected_ability = Globals.SelectableAbilities.PlaceBalloon
		Globals.selected_ability_changed.emit(Globals.BALLOON_ICON)
	if Input.is_action_just_pressed("select_light") and lights_allowed > 0:
		Globals.selected_ability = Globals.SelectableAbilities.ThrowLight
		Globals.selected_ability_changed.emit(Globals.LIGHT_ICON)
	
	if Input.is_action_just_pressed("activate_selected_ability"):
		activate_selected_ability()

func calculate_remaining_shadow_power():
	return get_allotted_shadow_power() - get_total_shadow_length(get_shadow_positions())

func calculate_remaining_shadow_power_without_mouse():
	return get_allotted_shadow_power() - get_total_shadow_length(get_objects_as_points())

func get_shadow_power_to_display():
	return max(0, ceili(calculate_remaining_shadow_power() / 10.0))


func _physics_process(delta: float) -> void:
	var change = Vector2(0,0)
	#change += int(Input.is_action_pressed("walk_up")) * Vector2(0, -1)
	#change += int(Input.is_action_pressed("walk_down")) * Vector2(0, 1)
	change += int(Input.is_action_pressed("walk_left")) * Vector2(-1, 0)
	change += int(Input.is_action_pressed("walk_right")) * Vector2(1, 0)
	change *= walk_speed * delta
	if get_shadow_power_to_display() <= 1 and len(captured_objects) > 1:
		var current_distance = (captured_objects[0].global_position as Vector2).distance_to(captured_objects[1].global_position)
		var new_distance = (captured_objects[0].global_position + change as Vector2).distance_to(captured_objects[1].global_position)
		if new_distance > current_distance:
			return
					
	if change:
		queue_redraw()
	for object in captured_objects:
		var current_capture_child = (object as Node2D).get_node("capturable") as CapturableComponent
		if current_capture_child != null:
			if current_capture_child.walkable:
				var change_dir = -1 if current_capture_child.inverted else 1
				(object as Node2D).global_position += change * change_dir
				object.move_and_slide()
		if player.is_on_wall():
			break

func _input(event: InputEvent) -> void:
	if event is InputEventMouse:
		queue_redraw()

func get_objects_as_points():
	return captured_objects.map(func(x):return x.global_position)




func get_shadow_positions():
	var ret = get_objects_as_points()
	if not should_show_shadow_to_mouse():
		return ret
	var distance_vector: Vector2 
	# var distance_vector: Vector2 = get_global_mouse_position() - ret[-1]
	# if len(old_mouse_positions) > 0:
	# 	distance_vector = old_mouse_positions[0] - ret[-1]
	# 	#for i in range(3, len(old_mouse_positions)):
	# 		#distance_vector = min(distance_vector, old_mouse_positions[i] - ret[-1])
			
	# else:
	distance_vector = get_global_mouse_position() - ret[-1]

	var total_len = get_total_shadow_length(ret)
	#prints("total_len", total_len)
	var remaining = max(0, get_allotted_shadow_power() - total_len)
	# var current_limit = lerp(float(farthest_shadow_stretched), float(remaining), .1)
	# farthest_shadow_stretched = current_limit
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
		var color = Color.DARK_RED if get_shadow_power_to_display() <= 1 else Color.BLACK
		draw_polyline(shadow_positions, color, 20)
		draw_circle(shadow_positions[-1], 10, color)
	#draw_polyline([Vector2(50, 100), Vector2(150, 100),Vector2(150, 100), Vector2(150, 200)], Color.BLACK, 10)
		
	#draw_line(%playerSprite.global_position, get_global_mouse_position(), Color.BLACK, 20)
