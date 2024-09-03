extends CanvasLayer

@onready var panel = $Panel
@onready var coins_label = $CoinsLabel
@onready var shop = $Shop
@onready var buy_fertilizer_button = $Shop/BuyFertilizer
@onready var fertilizer_label = $Shop/FertlizerLabel
@onready var wheat_label = $Crops/Wheat
@onready var pumpkin_label = $Crops/Pumpkin
@onready var buy_wheat_button = $Shop/BuyWheat
@onready var buy_pumpkin_button = $Shop/BuyPumpkin
@onready var ground_water_level_bar = $GroundWaterLevelBar
@onready var buy_drip_pipes_button = $Shop/BuyDripPipes
@onready var drip_pipes_label = $Shop/DripPipesLabel


func _ready():
	Globals.coins_change.connect(display_coins)
	Globals.fertilizer_count_change.connect(display_fertilizer)
	Globals.wheat_count_change.connect(harvest.bind("wheat"))
	Globals.pumpkin_count_change.connect(harvest.bind("pumpkin"))
	Globals.water_level_change.connect(display_ground_water_level_bar)
	Globals.drip_pipes_count_change.connect(display_drip_pipes_count)
	
	#Buttons
	buy_fertilizer_button.button_down.connect(buy_fertilizer)
	buy_drip_pipes_button.button_down.connect(buy_pipe)
	buy_wheat_button.button_down.connect(buy_wheat)
	buy_pumpkin_button.button_down.connect(buy_pumpkin)
	
	#Values
	Globals.coins = 500
	Globals.water_level = 100
	
func _process(delta):
	if Input.is_action_just_pressed("help"):
		if panel.visible:
			panel.visible = false
		else:
			panel.visible = true	
			
	if Input.is_action_just_pressed("shop"):
		if shop.visible:
			shop.visible = false
		else:
			shop.visible = true			

func display_coins():
	coins_label.text = "coins: " + str(Globals.coins)

func display_fertilizer():
	fertilizer_label.text = "Fertilizers: " + str(Globals.fertilizer_count)

func display_ground_water_level_bar():
	ground_water_level_bar.value = Globals.water_level

func buy_fertilizer():
	if Globals.coins >= 5:
		Globals.fertilizer_count += 1
		Globals.coins -= 5
	else:
		print("Coins not enought to buy a fertilizer")	
	
func harvest(crop):
	if crop == "wheat":
		wheat_label.text = str(Globals.wheat_count)
	else:
		pumpkin_label.text = str(Globals.pumpkin_count)	

func buy_wheat():
	if Globals.coins >= 1:
		Globals.coins -= 1
		Globals.wheat_count += 2
		
func buy_pumpkin():
	if Globals.coins >= 1:
		Globals.coins -= 1
		Globals.pumpkin_count += 2

func display_drip_pipes_count():
	drip_pipes_label.text = "Drip Pipes: " + str(Globals.drip_pipes_count)

func buy_pipe():
	if Globals.coins >= 25:
		Globals.drip_pipes_count += 1
		Globals.coins -= 25
	else:
		print("Coins not enought to buy a Drip Pipe")	
