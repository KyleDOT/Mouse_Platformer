extends Node

class_name  GameManager

signal toggle_game_paused(is_paused : bool)

#Creates pausable state
var game_paused : bool = false:
	get:
		return game_paused
	set(value):
		game_paused = value
		get_tree().paused = game_paused
		emit_signal("toggle_game_paused", game_paused)

#Esc to pause/unpause
func _input(event : InputEvent):
	if event.is_action_pressed("ui_cancel"):
		game_paused = !game_paused

#Goes to main menu
func _on_ready():
	get_tree().change_scene_to_file("res://main_menu.tscn")
