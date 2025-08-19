extends Node2D

@export var noise_height_texture :NoiseTexture2D
var noise : Noise

#size of the map
var width := 50
var height := 50

@onready var tile_map: TileMap = $TileMap

var source_id = 0
var water_atlas = Vector2i(6, 6)
var land_atlas = Vector2i(5, 1)

#terrain arrays
var water_cliff_arr = []
var terrain_water_cliff_int = 2

var cliff_tile_arr = []
var terrain_cliff_int = 0


#layers
var water_layer = 0
var ground_layer = 1
var cliff_layer = 2
var enviroment_layer = 3


var noise_val_arr = []

func _ready() -> void:
	noise = noise_height_texture.noise
	call_deferred("generate_world")
	
func generate_world():
	for x in range(width):
		for y in range(height):
			var noise_val = noise.get_noise_2d(x, y)
			
			#placing ground
			if noise_val >= 0.0:
				if noise_val > 0.5:
					cliff_tile_arr.append(Vector2i(x, y))
				
				water_cliff_arr.append(Vector2i(x, y))
				
			#place water
			tile_map.set_cell(water_layer, Vector2(x, y), source_id, water_atlas)
		tile_map.set_cells_terrain_connect(ground_layer, water_cliff_arr, terrain_water_cliff_int, 0)
		tile_map.set_cells_terrain_connect(cliff_layer, cliff_tile_arr, terrain_cliff_int, 0)
