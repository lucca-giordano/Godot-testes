extends Node2D

func _on_button_pressed():
	Util.LoadGame()
	get_tree().change_scene_to_file("res://scenes/Mostrador.tscn")
