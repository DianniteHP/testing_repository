extends Node2D

@onready var tile_map: TileMap = $TileMap
var ground_layer := 0
var enviroment_layer := 2
var can_place_ore_custom_data = "can_place_ore"
var can_place_dirt_custom_data = "can_place_dirt"

enum FARMING_MODES {ore, dirt}
var farming_mode_state = FARMING_MODES.dirt

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("toogle_dirt"):
		farming_mode_state = FARMING_MODES.dirt
		print("dirt mode")
	if Input.is_action_just_pressed("toogle_ore"):
		farming_mode_state = FARMING_MODES.ore
		print("ore mode")
		
	if Input.is_action_just_pressed("click"):
		var source_id = 0
		var mouse_pos = get_local_mouse_position()
		mouse_pos /= tile_map.scale
		var tile_pos = tile_map.local_to_map(mouse_pos)
		print(tile_pos)
		var atlas_coord : Vector2i
		
		
		if farming_mode_state == FARMING_MODES.ore:
			atlas_coord = Vector2i(6,2)
			if retreve_custom_data(tile_pos, can_place_ore_custom_data, ground_layer):
				tile_map.set_cell(enviroment_layer, tile_pos, source_id, atlas_coord)
		elif farming_mode_state == FARMING_MODES.dirt:
			atlas_coord = Vector2i(5,4)
			if retreve_custom_data(tile_pos, can_place_dirt_custom_data, ground_layer):
				tile_map.set_cell(ground_layer, tile_pos,  source_id, atlas_coord)
		

func retreve_custom_data(tile_pos,custom_data_layer, layer):
	var tile_data := tile_map.get_cell_tile_data(layer, tile_pos)
	if tile_data:
		return tile_data.get_custom_data(custom_data_layer)
	else:
		return false
	
	
	
