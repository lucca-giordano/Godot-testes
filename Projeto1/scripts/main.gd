extends Node2D

func _ready():
	#Utils.SaveGame()
	Utils.LoadGame()

func _on_button_play_pressed():
	get_tree().change_scene_to_file("res://scenes/world.tscn")

func _on_button_quit_pressed():
	get_tree().quit()
