extends Node2D

func _on_button_pressed():
	Game.Numero += 1
	Util.SaveGame()
