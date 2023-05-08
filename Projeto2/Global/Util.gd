extends Node

const SAVE_PATH = "res://savegame.bin"

func SaveGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data: Dictionary = {
		"Numero" : Game.Numero,
	}
	var jstr = JSON.stringify(data)
	file.store_line(jstr)
	
func LoadGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if FileAccess.file_exists(SAVE_PATH):
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())
			if current_line:
				Game.Numero = current_line["Numero"]
