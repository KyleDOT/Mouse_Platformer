extends Control

func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://main_menu.tscn")
	queue_free()

#Kyle links
func _on_kyle_web_pressed():
	OS.shell_open("https://kyledot.net/")

func _on_kyle_itch_io_pressed():
	OS.shell_open("https://kyledot.itch.io/")

func _on_kyle_github_pressed():
	OS.shell_open("https://github.com/KyleDOT")

func _on_kyle_instagram_pressed():
	OS.shell_open("https://www.instagram.com/kyled0t")
