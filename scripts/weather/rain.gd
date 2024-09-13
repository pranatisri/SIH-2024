extends Node2D

@onready var rain = $rain


func _process(_delta):
	var rain_type = Globals.rain_type
	if rain_type == "none":
		disable_rain()
	else:
		enable_rain(rain_type)
	pass

func changeRain(type): 
	if type == "light":
		to_light_rain()
	elif type == "medium":
		to_medium_rain()
	elif type == "heavy":
		to_heavy_rain()
	elif type == "storm":
		to_storm()
	pass
	
func enable_rain(type = "none"):
	changeRain(type)
	
func disable_rain():
	rain.color = "#ffffff00"
	rain.material.set_shader_parameter("rain_amount", 0)
	rain.set_meta("rain_type", "none")


func to_light_rain():
	rain.color = "#ffffff00"
	rain.material.set_shader_parameter("near_rain_length",0.05)
	rain.material.set_shader_parameter("far_rain_length", 0.05)
	rain.material.set_shader_parameter("near_rain_width", 0.1)
	rain.material.set_shader_parameter("far_rain_width", 0.2)
	rain.material.set_shader_parameter("base_rain_speed", 0.2)
	rain.material.set_shader_parameter("additional_rain_speed", 0.05)
	rain.material.set_shader_parameter("rain_amount", 400)
	rain.material.set_shader_parameter("slant", 0)
	rain.material.set_shader_parameter("rain_color", Color("#cccccc"))
		
func to_medium_rain():
	rain.color = "#ffffff00"
	rain.material.set_shader_parameter("near_rain_length",0.1)
	rain.material.set_shader_parameter("far_rain_length", 0.01)
	rain.material.set_shader_parameter("near_rain_width", 0.2)
	rain.material.set_shader_parameter("far_rain_width", 0.4)
	rain.material.set_shader_parameter("base_rain_speed", 0.7)
	rain.material.set_shader_parameter("additional_rain_speed", 0.5)
	rain.material.set_shader_parameter("rain_amount", 300)
	rain.material.set_shader_parameter("slant", 0.2)
	rain.material.set_shader_parameter("rain_color", Color("#f4fbfe"))
	
func to_heavy_rain():
	rain.color = "#ffffff00"
	rain.material.set_shader_parameter("near_rain_length",0.07)
	rain.material.set_shader_parameter("far_rain_length", 0.04)
	rain.material.set_shader_parameter("near_rain_width", 0.6)
	rain.material.set_shader_parameter("far_rain_width", 0.5)
	rain.material.set_shader_parameter("base_rain_speed", 0.7)
	rain.material.set_shader_parameter("additional_rain_speed", 0.5)
	rain.material.set_shader_parameter("rain_amount", 700)
	rain.material.set_shader_parameter("slant", 0.4)
	rain.material.set_shader_parameter("rain_color", Color("#7debf1"))
	
func to_storm():
	rain.color = "#2929299a"
	rain.material.set_shader_parameter("near_rain_length",0.1)
	rain.material.set_shader_parameter("far_rain_length", 0.15)
	rain.material.set_shader_parameter("near_rain_width", 0.5)
	rain.material.set_shader_parameter("far_rain_width", 0.6)
	rain.material.set_shader_parameter("base_rain_speed", 1)
	rain.material.set_shader_parameter("additional_rain_speed", 0.9)
	rain.material.set_shader_parameter("rain_amount", 1000)
	rain.material.set_shader_parameter("slant", 0.6)
	rain.material.set_shader_parameter("rain_color", Color("#415852c4"))
