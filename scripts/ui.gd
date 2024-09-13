extends Control

@onready var ingame = $Ingame
@onready var store = $Store
@onready var gw_amount = $Ingame/STATS/ground_water/gw_amount
@onready var coins_amount = $Ingame/STATS/coins/coins_amount
@onready var fertilizer_amount_on_hand = $Store/CenterContainer/storefront/CenterContainer/VBoxContainer/fertilizer/amount_on_hand
@onready var buy_fertilizer = $Store/CenterContainer/storefront/CenterContainer/VBoxContainer/fertilizer/buy_fertilizer
@onready var pipes_amount_on_hand = $Store/CenterContainer/storefront/CenterContainer/VBoxContainer/drip_pipes/amount_on_hand
@onready var buy_drip_pipes = $Store/CenterContainer/storefront/CenterContainer/VBoxContainer/drip_pipes/buy_drip_pipes
@onready var wells_amount_on_hand = $Store/CenterContainer/storefront/CenterContainer/VBoxContainer/recoery_wells/amount_on_hand
@onready var buy_recovery_wells = $Store/CenterContainer/storefront/CenterContainer/VBoxContainer/recoery_wells/buy_recovery_wells
@onready var wheat_amount = $Store/CenterContainer/storefront/HBoxContainer/wheat/wheat_count
@onready var wheat_select = $Store/CenterContainer/storefront/HBoxContainer/wheat/wheat_select
@onready var pumpkin_amount = $Store/CenterContainer/storefront/HBoxContainer/pumpkin/pumpkin_amount
@onready var pumpkin_select = $Store/CenterContainer/storefront/HBoxContainer/pumpkin/pumpkin_select
@onready var coins_amount_store = $Store/CenterContainer/storefront/coins/coins_amount
@onready var turn_on_pump_button = $"../../Pump"
@onready var in_game = $"../InGame"


func _ready():
	Globals.water_level_change.connect(_on_ground_water_level_change)
	Globals.coins_change.connect(_on_coins_amount_change)
	
	Globals.util_count_changed.connect(_on_util_count_change)
	Globals.wheat_count_change.connect(_on_wheat_count_changed)
	Globals.pumpkin_count_change.connect(_on_pumpkin_count_changed)
	
	#Buttons
	buy_fertilizer.pressed.connect(_on_buy_fertilizer_button_pressed)
	buy_drip_pipes.pressed.connect(_on_buy_pipes_button_pressed)
	buy_recovery_wells.pressed.connect(_on_buy_wells_button_pressed)
	wheat_select.pressed.connect(_on_buy_wheat_button_pressed)
	pumpkin_select.pressed.connect(_on_buy_pumpkin_button_pressed)
	
	
func _process(_delta):
	if Input.is_action_just_pressed("shop"):
		toggle_shop()
		
func toggle_shop():
	if store.visible:
		store.visible = false
		ingame.visible = true
		ingame.visible = true
		turn_on_pump_button.visible= true
	else:
		store.visible = true
		ingame.visible = false		
		ingame.visible = false
		turn_on_pump_button.visible = false
		
func _on_ground_water_level_change():
	gw_amount.text = str(Globals.water_level) + "%"

func _on_coins_amount_change():
	coins_amount.text = str(Globals.coins) 
	coins_amount_store.text = coins_amount.text
	
func _on_util_count_change():
	fertilizer_amount_on_hand.text = str(Globals.util_count[0])
	pipes_amount_on_hand.text = str(Globals.util_count[1])
	wells_amount_on_hand.text = str(Globals.util_count[2])
	
func _on_buy_fertilizer_button_pressed():
	if Globals.coins > 20:
		var x = Globals.util_count
		Globals.util_count = [x[0]+1, x[1], x[2]]	
		Globals.coins -= 20
		
func _on_buy_pipes_button_pressed():
	if Globals.coins > 20:
		var x = Globals.util_count
		Globals.util_count = [x[0], x[1]+1, x[2]]	
		Globals.coins -= 20
		
func _on_buy_wells_button_pressed():
	if Globals.coins > 20:
		var x = Globals.util_count
		Globals.util_count = [x[0], x[1], x[2]+1]	
		Globals.coins -= 20				

func _on_buy_wheat_button_pressed():
	if Globals.coins> 1:
		Globals.coins -= 1
		Globals.wheat_count += 1

func _on_wheat_count_changed():
	wheat_amount.text = str(Globals.wheat_count)
	
func _on_buy_pumpkin_button_pressed():
	if Globals.coins> 1:
		Globals.coins -= 1
		Globals.pumpkin_count += 1
		
func _on_pumpkin_count_changed():
	pumpkin_amount.text	 = str(Globals.pumpkin_count)	
