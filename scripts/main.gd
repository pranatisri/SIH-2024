extends TileMap

#References
@onready var player = $World/Player
@onready var grid_helper = $World/GridHelper
@onready var water_handler = $WaterHandler
@onready var wheat_button = $CanvasLayer/Crops/Wheat
@onready var pumpkin_button = $CanvasLayer/Crops/Pumpkin

#Preloads
const wheat_seed = preload("res://Objects/wheat.tscn")
const pumpkin_seed = preload("res://Objects/pumpkin.tscn")

#data
var curr_seed = wheat_seed
var stored_plants: Dictionary = {}
var digged_cells = []

func _ready():
	player.plant_seed.connect(handle_plant_seed)
	water_handler.water_available.connect(water_display)
	
	#Connect Buttons
	wheat_button.button_down.connect(func(): curr_seed=wheat_seed)
	pumpkin_button.button_down.connect(func(): curr_seed=pumpkin_seed)

func _process(_delta):
	var player_map_cod = local_to_map(player.global_position)
	var player_dir = player.direction
	var player_maps_cord = player_map_cod + Vector2i(player_dir) /16
	grid_helper.global_position = player_maps_cord*16

func _input(event):
	if event.is_action_type():
		update_tiles()

func handle_plant_seed():
	var cell_local_cood = local_to_map(grid_helper.position)
	var tile: TileData = get_cell_tile_data(1, cell_local_cood)
	
	if tile == null or curr_seed == null:
		return
	
	var is_fertilized = tile.get_custom_data("fertilized")
	var is_ground = tile.get_custom_data("garden")
	var is_drip_irrigated = tile.get_custom_data("drip_irrigated")
	var is_fertilized_pipe = tile.get_custom_data("fertilized_pipe")
	
	plant_seed(cell_local_cood,is_ground, is_fertilized,is_drip_irrigated, is_fertilized_pipe)			

func is_harvestable(cords):
	if stored_plants.get(cords) == null:
		return false	
	if stored_plants[cords].harvest_ready:
		return true	

func plant_seed(cords,is_ground, is_fertilized, is_dripped, is_dripped_fertilized):
	var can_plant_seed = not stored_plants.has(cords) and Globals.water_available
	var can_plant_wheat = curr_seed == wheat_seed and Globals.wheat_count >= 1
	var can_plant_pumpkin = curr_seed == pumpkin_seed and Globals.pumpkin_count >= 1
	
	var seed = curr_seed.instantiate()
				
	if can_plant_seed:
		
		if is_ground:
			seed.add_to_group('ground_crop')
		elif is_fertilized:
			seed.add_to_group('fertilized_crop')	
		elif is_dripped:
			seed.add_to_group('dripped_crop')	
		elif is_dripped_fertilized:
			seed.add_to_group('dripped_fertilized')	
			
		if can_plant_wheat:
			stored_plants[cords] = seed
			seed.name = seed.name + str(Globals.crop_count)
			get_node("World/Crops").add_child(seed)
			seed.global_position = map_to_local(cords)
			Globals.wheat_count -= 1
			
		elif can_plant_pumpkin:
			stored_plants[cords] = seed
			seed.name = seed.name + str(Globals.crop_count)
			get_node("World/Crops").add_child(seed)
			seed.global_position = map_to_local(cords)
			Globals.pumpkin_count -= 1
			
	elif is_harvestable(cords):
		stored_plants[cords].harvest()
		stored_plants.erase(cords)		
		
	return can_plant_seed and (can_plant_pumpkin or can_plant_wheat)

func water_display(water_available):
	if water_available:
		set_layer_enabled(4, true)
	else:
		set_layer_enabled(4, false)	
		
func update_tiles():
	var tile_pos = local_to_map(get_global_mouse_position())
	var cell_data = get_cell_tile_data(1, tile_pos)
	
	if cell_data != null:
		var fertilizied = cell_data.get_custom_data("fertilized")
		var drip_irrigated = cell_data.get_custom_data("drip_irrigated")
		var fert_drip = cell_data.get_custom_data("fertilized_pipe")
		
		if fert_drip:
			return 
			
		if Input.is_action_just_pressed("fertilize"):
			if Globals.fertilizer_count > 0:
				Globals.fertilized_tiles += 1
				
				if not fertilizied:	
					set_cell(1,tile_pos,3,Vector2i(0,0))			
				if drip_irrigated:
					set_cell(1,tile_pos,4,Vector2i(0,0))
					
				Globals.fertilizer_count -= 1	
				
		if Input.is_action_just_pressed("drip_irrigate"):
			if Globals.drip_pipes_count>0:
				if not drip_irrigated:
					set_cell(1, tile_pos,2,Vector2i(0,0))	
				if fertilizied:
					set_cell(1,tile_pos,4,Vector2i(0,0))	
				Globals.drip_pipes_count -= 1
			

# TEST CODE
func sim_rain():
	if Input.is_action_just_pressed("test"):
		for tile_pos in digged_cells:
			set_cell(1,tile_pos, 0, Vector2i(16,5))
