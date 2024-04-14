extends Node

signal captured_object_signal
signal captured_position_signal
signal captured_walkable_signal

signal selected_ability_changed
signal icons_setup

signal used_balloon


enum SelectableAbilities{
	NormalShadow=0,
	PlaceBalloon=1,
	ThrowLight=2,
}


var current_level = 0
var CURRENT_SHADOW_CONTROLLER: ShadowController

var selected_ability: SelectableAbilities

var SHADOW_ICON: TextureButton
var BALLOON_ICON: TextureButton
var LIGHT_ICON: TextureButton

func start_win_sequence():
	#TODO: play sound
	load_next_level()

func count_levels():
	return 3
	#var dir = DirAccess.open("res://levels/")
	#var file_name = dir.get_next()
	#var ret = 0
	#dir.list_dir_begin()
	#while file_name != "":
		#if dir.current_is_dir():
			#print("Found directory: " + file_name)
		#else:
			#ret += 1
			#print("Found file: " + file_name)
		#file_name = dir.get_next()
	#return ret

func load_next_level():
	current_level += 1
	current_level %= count_levels()
	get_tree().change_scene_to_file.call_deferred("res://levels/level%d.tscn" % [current_level])
	
func reload_current_level():
	get_tree().change_scene_to_file.call_deferred("res://levels/level%d.tscn" % [current_level])
