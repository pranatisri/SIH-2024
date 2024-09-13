extends CanvasLayer

@onready var mode_button = $InGame/ModeButton
@onready var moat_water_level_bar = $InGame/MoatWaterLevelBar
@onready var water_layer = $"../Tilemap/Water"

func _ready():
	Globals.moat_water_level_changed.connect(_on_moat_water_level_changed)
	
	#Buttons
	mode_button.toggled.connect(_on_mode_button_toggle)
		

		
func _on_mode_button_toggle(util):
	if util:
		Globals.curr_mode = 1
	else:
		Globals.curr_mode = 0	
		
func _on_moat_water_level_changed():
	moat_water_level_bar.value =Globals.moat_water_level
	if Globals.moat_water_level==0:
		water_layer.visible = false
	else:
		water_layer.visible = true	
