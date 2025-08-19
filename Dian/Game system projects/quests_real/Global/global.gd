extends Node

var save_path = "user://savegame.save"

var quest_exp := 0
var level := 1

func save():
	var file = FileAccess.open(save_path,FileAccess.WRITE)
	file.store_var(Global.quest_exp)
	file.store_var(Global.level)
	
func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		quest_exp = file.get_var(Global.quest_exp)
		level = file.get_var(Global.level)
	else:
		print("no data found")
