extends Node


signal coins_change
signal digs_change
signal wheat_count_change
signal pumpkin_count_change
signal water_level_change
signal fertilized_tiles_number_change
signal fertilizer_count_change
signal drip_pipes_count_change

var water_available: bool = true
var coins: int:
	set(value):
		coins = value
		emit_signal("coins_change")		
var digs: int:
	set(value):
		if coins >= 1:
			digs = value
			coins -= 1
			emit_signal("digs_change")		
		else:
			digs = value	
var water_level: int:
	set(value):
		if value >= 0:
			water_level = value
		else:
			value = 0
		emit_signal("water_level_change")				
var wheat_count: int:
	set(value):
		wheat_count = value
		emit_signal("wheat_count_change")							
var pumpkin_count: int:
	set(value):
		pumpkin_count = value
		emit_signal("pumpkin_count_change")
var crop_count: int:
	get():
		crop_count += 1
		return crop_count
var fertilized_tiles: int:
	set(value):
		fertilized_tiles = value
		emit_signal("fertilized_tiles_number_change")
var fertilizer_count: int:
	set(value):
		fertilizer_count = value
		emit_signal("fertilizer_count_change")
var drip_pipes_count: int:
	set(value):
		drip_pipes_count = value
		emit_signal("drip_pipes_count_change")
