extends Node2D

# Values
var index = 0 
var harvest_ready: bool = false
var crop_growth_time = 5
var crop_growth_speed = 1

# Refernces
@onready var animation_player = $AnimationPlayer
@onready var timer: Timer = $Timer

func _ready():
	var grounded_crop = is_in_group('ground_crop')
	var fertilized_crop = is_in_group('fertilized_crop')
	var dripped_crop = is_in_group('dripped_crop')
	var dripped_fertilized_crop = is_in_group('dripped_fertilized')
	
	crop_growth_speed = 5 if fertilized_crop or dripped_fertilized_crop else 1
	
	animation_player.play(str(index))
	timer.start(crop_growth_time/crop_growth_speed)
	timer.timeout.connect(next_stage)

func next_stage():
	if index < 3:
		index += 1
		animation_player.play(str(index))
		timer.start(crop_growth_time/crop_growth_speed)
		

func ready_to_harvest():
	harvest_ready = true

func harvest():
	if "pumpkin" in name:
		Globals.pumpkin_count += 1
	else:
		Globals.wheat_count += 1	
	Globals.coins += 2	
	queue_free()	
