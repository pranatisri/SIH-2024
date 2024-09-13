extends VSplitContainer

const WHEAT_SPRITE = preload("res://assets/old/Crops/wheat/wheat_04.png")
const PUMPKIN_SPRITE= preload("res://assets/old/Crops/pumkin/pumpkin_04.png")


#REFERENCES
@onready var current_crop_sprite = $currentCropVSplitContainer/currentCropHSplitContainer/currentCropSprite
@onready var display_crops_button = $currentCropVSplitContainer/displayCropsButton
@onready var select_crop_h_split_container = $selectCropHSplitContainer
@onready var select_wheat_button = $selectCropHSplitContainer/selectWheatButton
@onready var select_pumpkin_button = $selectCropHSplitContainer/selectPumpkinButton
@onready var current_crop_v_split_container = $currentCropVSplitContainer
@onready var current_sprite_count = $currentCropVSplitContainer/currentCropHSplitContainer/currentSpriteCount


func _ready():
	display_crops_button.pressed.connect(_on_display_crops_button_pressed)
	select_wheat_button.pressed.connect(_on_select_wheat_button)
	select_pumpkin_button.pressed.connect(_on_select_pumpkin_button)
	
	Globals.wheat_count_change.connect(_on_crop_count_change)
	Globals.pumpkin_count_change.connect(_on_crop_count_change)	
	
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
