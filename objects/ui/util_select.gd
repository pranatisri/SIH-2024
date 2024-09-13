extends HBoxContainer


@onready var current_util_sprite = $CurrentUtilContainer/CurrentUtilSprite
@onready var current_util_count_label = $CurrentUtilContainer/CurrentUtilCountLabel
@onready var select_util_button = $SelectUtilButton
@onready var util_select_container = $UtilSelectContainer
@onready var fertilizer_button = $UtilSelectContainer/FertilizerButton
@onready var pipe_button = $UtilSelectContainer/PipeButton
@onready var shovel_buttin = $UtilSelectContainer/ShovelButtin

# Preloads
const FERTILIZER = preload("res://assets/old/icons/fertilizer.png")
const PIPE = preload("res://assets/old/icons/pipe.png")
const SHOVEL = preload("res://assets/old/icons/shovel.png")

func _ready():
	#Util Selector Signals
	select_util_button.pressed.connect(_on_select_util_button_pressed)
	fertilizer_button.pressed.connect(_on_fertilizer_button_pressed)
	pipe_button.pressed.connect(_on_pipe_button_pressed)
	shovel_buttin.pressed.connect(_on_shovel_button_pressed)
	
	#Global Signals
	Globals.util_count_changed.connect(_on_util_count_changed)
	
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
