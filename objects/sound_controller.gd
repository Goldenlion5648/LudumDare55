extends Node2D

@export var background_music: AudioStreamPlayer2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.captured_object_signal.connect(play_capture_sound)
	Globals.used_balloon_ability.connect(play_summon_balloon_sound)
	Globals.used_shadow_ability.connect(play_summon_shadow_sound)
	Globals.retrack_shadows_signal.connect(play_retract_shadows_sound)
	Globals.play_win_sound_signal.connect(play_win_sound)
	Globals.selected_ability_changed.connect(play_select_ability_sound)
	Globals.button_pressed_signal.connect(play_button_click_sound)
	Globals.out_of_item_signal.connect(play_fail_sound)
	background_music.finished.connect(play_background_music)
	play_background_music()
	
func play_background_music():
	background_music.play()	

func play_fail_sound():
	$fail.play()
	
func play_select_ability_sound(_extra):
	$select_ability.play()
	
func play_button_click_sound():
	$press_button.play()

func play_capture_sound(_extra):
	$capture_sound.play()
	
func play_summon_balloon_sound(_extra):
	$summon_balloon.play()
	$summon_balloon2.play()

func play_summon_shadow_sound():
	$summon_shadow.play()
	$summon_shadow2.play()

func play_retract_shadows_sound():
	$retract_shadows.play()

func play_win_sound():
	$win_sound.play()
