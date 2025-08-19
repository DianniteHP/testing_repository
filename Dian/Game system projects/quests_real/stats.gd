extends Control

@export var level_label :Label
@export var exp_needed_label :Label
var exp_needed := 25

func _ready() -> void:
	exp_needed = (Global.level * 25) * 1.2
	while Global.quest_exp >= exp_needed:
		Global.quest_exp -= exp_needed
		Global.level += 1
		Global.save()
		
	level_label.text = "/  level: " + str(Global.level)
	exp_needed_label.text = "/ exp needed: " + str(exp_needed)
	$exp.text = "exp: " + str(Global.quest_exp)
	
func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://quests.tscn")
