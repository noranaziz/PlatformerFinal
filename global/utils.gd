extends Node

const SAVE_PATH = "res://savegame.bin"

# save file
func saveGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data: Dictionary = {
		"playerHP": Game.playerHP,
		"gold": Game.gold,
		"stars": Game.stars,
		"lvl1Cleared": Game.lvl1Cleared,
		"lvl2Cleared": Game.lvl2Cleared,
		"lvl3Cleared": Game.lvl3Cleared,
	}
	var jstr = JSON.stringify(data)
	file.store_line(jstr)

# load file
func loadGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if FileAccess.file_exists(SAVE_PATH) == true:
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())
			if current_line:
				Game.playerHP = current_line["playerHP"]
				Game.gold = current_line["gold"]
				Game.stars = current_line["stars"]
				Game.lvl1Cleared = current_line["lvl1Cleared"]
				Game.lvl2Cleared = current_line["lvl2Cleared"]
				Game.lvl3Cleared = current_line["lvl3Cleared"]

# clear file
func clearGame():
	Game.playerHP = 10
	Game.gold = 0
	Game.stars = 0
	Game.lvl1Cleared = false
	Game.lvl2Cleared = false
	Game.lvl3Cleared = false
	saveGame()
