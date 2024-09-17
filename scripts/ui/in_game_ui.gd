extends Control

# Preloads
const FERTILIZER = preload("res://assets/old/icons/fertilizer.png")
const PIPE = preload("res://assets/old/icons/pipe.png")
const SHOVEL = preload("res://assets/old/icons/shovel.png")
const WHEAT_SPRITE = preload("res://assets/old/Crops/wheat/wheat_04.png")
const PUMPKIN_SPRITE= preload("res://assets/old/Crops/pumkin/pumpkin_04.png")

#Sprites 
@onready var current_crop_sprite = $CropsVSplitContainer/currentCropVSplitContainer/currentCropHSplitContainer/currentCropSprite
@onready var current_sprite_count = $CropsVSplitContainer/currentCropVSplitContainer/currentCropHSplitContainer/currentSpriteCount
@onready var current_util_sprite = $UtilsHBoxContainer/CurrentUtilContainer/CurrentUtilSprite

#Labels
@onready var current_util_count_label = $UtilsHBoxContainer/CurrentUtilContainer/CurrentUtilCountLabel
@onready var coins_amount: Label = $StatsHContainer/coins/coins_amount
@onready var gw_amount: Label = $StatsHContainer/ground_water/gw_amount

#Buttons
@onready var display_crops_button = $CropsVSplitContainer/currentCropVSplitContainer/displayCropsButton
@onready var select_wheat_button = $CropsVSplitContainer/selectCropHSplitContainer/selectWheatButton
@onready var select_pumpkin_button = $CropsVSplitContainer/selectCropHSplitContainer/selectPumpkinButton
@onready var select_util_button = $UtilsHBoxContainer/SelectUtilButton
@onready var fertilizer_button = $UtilsHBoxContainer/UtilSelectContainer/FertilizerButton
@onready var pipe_button = $UtilsHBoxContainer/UtilSelectContainer/PipeButton
@onready var shovel_buttin = $UtilsHBoxContainer/UtilSelectContainer/ShovelButtin

#Container
@onready var select_crop_h_split_container = $CropsVSplitContainer/selectCropHSplitContainer
@onready var current_crop_v_split_container = $CropsVSplitContainer/currentCropVSplitContainer
@onready var util_select_container = $UtilsHBoxContainer/UtilSelectContainer

func _ready():
	#Label Update
	Globals.wheat_count_change.connect(_on_crop_count_change)
	Globals.pumpkin_count_change.connect(_on_crop_count_change)	
	Globals.util_count_changed.connect(_on_util_count_changed)
	Globals.water_level_change.connect(_on_ground_water_level_changed)
	Globals.coins_change.connect(_on_coins_amount_change)
	
	#Buttons Pressed
	display_crops_button.pressed.connect(_on_display_crops_button_pressed)
	select_wheat_button.pressed.connect(_on_select_wheat_button)
	select_pumpkin_button.pressed.connect(_on_select_pumpkin_button)
	select_util_button.pressed.connect(_on_select_util_button_pressed)
	fertilizer_button.pressed.connect(_on_fertilizer_button_pressed)
	pipe_button.pressed.connect(_on_pipe_button_pressed)
	shovel_buttin.pressed.connect(_on_shovel_button_pressed)
	
	
func _on_display_crops_button_pressed():
	if select_crop_h_split_container.visible:
		select_crop_h_split_container.visible = false
	else:
		select_crop_h_split_container.visible = true	
		current_crop_v_split_container.visible = false

func _on_select_wheat_button():
	Globals.curr_seed = Globals.wheat_seed
	select_crop_h_split_container.visible = false
	current_crop_sprite.texture = WHEAT_SPRITE
	current_crop_v_split_container.visible = true
	
func _on_select_pumpkin_button():
	Globals.curr_seed= Globals.pumpkin_seed	
	select_crop_h_split_container.visible = false	
	current_crop_sprite.texture = PUMPKIN_SPRITE
	current_crop_v_split_container.visible = true

func _on_crop_count_change():
	if Globals.curr_seed == Globals.wheat_seed:
		current_sprite_count.text = str(Globals.wheat_count)
	elif Globals.curr_seed == Globals.pumpkin_seed:
		current_sprite_count.text = str(Globals.pumpkin_count)

func _on_select_util_button_pressed():
	util_select_container.visible = true

func _on_fertilizer_button_pressed():
	Globals.curr_util = 0
	current_util_sprite.texture = FERTILIZER
	util_select_container.visible = false
	current_util_count_label.text = str(Globals.util_count[0])	
		
func _on_pipe_button_pressed():
	Globals.curr_util = 1
	current_util_sprite.texture = PIPE
	util_select_container.visible = false
	current_util_count_label.text = str(Globals.util_count[1])	

func _on_shovel_button_pressed():
	Globals.curr_util = 2
	current_util_sprite.texture = SHOVEL
	util_select_container.visible = false
	current_util_count_label.text = str(Globals.util_count[2])	
			
func _on_util_count_changed():
	current_util_count_label.text = str(Globals.util_count[Globals.curr_util])
	print(Globals.util_count)	
	
func _on_ground_water_level_changed():
	gw_amount.text = str(Globals.water_level)
	
func _on_coins_amount_change():
	coins_amount.text = str(Globals.coins)		
