extends Node2D

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Levels/L1.tscn")
	queue_free()

func _on_credits_button_pressed():
	get_tree().change_scene_to_file("res://Menus/credits.tscn")
	queue_free()

func _on_quit_button_pressed():
	get_tree().quit()
