extends Node

signal water_available(value)
@onready var water_button = $"../CanvasLayer/WaterButton"
@onready var crops: Node = $"../World/Crops"


func _ready():
	crops.child_entered_tree.connect(handle_new_crops)
	water_button.button_down.connect(water_button_down)
	Globals.water_level_change.connect(deplete_water)
	Globals. fertilized_tiles_number_change.connect(fertilized_tiles_handler)

func water_button_down():
	Globals.water_available = true
	emit_signal("water_available", true)

func handle_new_crops(node):
	var crops  = node.get_parent().get_children()
	var diverse = are_diveristy(crops)
	var is_dripped = node.is_in_group("dripped_crop") or node.is_in_group("dripped_fertilized")
	var is_dripped_diverse = diverse and is_dripped
	
	if is_dripped_diverse:
		Globals.water_level -= 1
	elif is_dripped:
		Globals.water_level -= 2
	elif diverse:
		Globals.water_level -= 5
	else:
		Globals.water_level -= 10

func are_diveristy(crops):
	var pumpkin = false
	var wheat = false
	
	for crop in crops:
		if crop.is_in_group('pumpkins'):
			pumpkin = true
			break

	for crop in crops:
		if crop.is_in_group('wheats'):
			wheat = true
			break	
	
	return pumpkin and wheat			

func deplete_water():
	if Globals.water_level == 0:
		Globals.water_available = false
		emit_signal("water_available", false)	
		
func fertilized_tiles_handler():
	Globals.water_level -= 5
	
