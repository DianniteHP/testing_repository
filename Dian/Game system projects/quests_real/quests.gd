extends Control

@export var quest_name :Label
@export var quest_difficulty :Label
@export var quest_value :Label
var quest_count := 0
var idk:int
var idk_text :String
var value := 1
var reward_exp :int
var visable_bool := false

func _ready() -> void:
	Global.load_data()
	visable_bool = false
	quest_visable()
	$Quest_count.text = "exp: " + str(Global.quest_exp)
	print(Global.quest_exp)

func _on_confirm_quest_pressed() -> void:
	if value > 1:
		value -= 1
		quest_value.text = "// " + str(value) + " left"
	else:
		Global.quest_exp += reward_exp
		Global.save()
		$Quest_count.text = "exp: " + str(Global.quest_exp)
		visable_bool = false
		quest_visable()
		$quest_amount.text = "amount: " + str(value)

func _on_option_button_item_selected(index: int) -> void:
	idk = $OptionButton.get_selected()
	idk_text = $OptionButton.get_item_text(idk)
		
func _on_add_button_pressed() -> void:
	if $TextEdit.text == "" or $OptionButton.get_selected() == -1:
		quest_name.text = "error"
	else:
		match idk:
			0:
				reward_exp = 5
			1:
				reward_exp = 15
			2:
				reward_exp = 25
			3:
				reward_exp = 50
		quest_name.text = $TextEdit.text
		quest_difficulty.text = idk_text
		quest_value.text = "// " + str(value) + " left"
		visable_bool = true
		quest_visable()

func _on_add_pressed() -> void:
	value += 1
	$quest_amount.text = "amount: " + str(value)
	
func _on_decrease_pressed() -> void:
	if value > 1:
		value -= 1
	$quest_amount.text = "amount: " + str(value)

func quest_visable():
	$confirm_quest.visible = visable_bool
	quest_name.visible = visable_bool
	quest_value.visible = visable_bool
	quest_difficulty.visible = visable_bool


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://stats.tscn")
