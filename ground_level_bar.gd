extends ProgressBar

func _ready():
	Globals.healthChange.connect(handle_health_change)
	
func handle_health_change():
	value = Globals.health	
