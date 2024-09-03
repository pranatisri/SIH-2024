extends CharacterBody2D

@onready var player_sprite = $AnimatedSprite2D
signal plant_seed

var direction = Vector2.ZERO
const SPEED = 150


func _physics_process(_delta):
	handle_movement()
	move_and_slide()	
	
func handle_movement():
	if Input.is_action_just_pressed("PlantSeed"):
		emit_signal("plant_seed")
		
	if Input.is_action_pressed("MoveUp"):
		player_sprite.play("walk_back")
		direction = Vector2.UP

	elif Input.is_action_pressed("MoveDown"):
		player_sprite.play("walk_front")
		direction = Vector2.DOWN
			
	elif Input.is_action_pressed("MoveRight"):
		player_sprite.play("walk_side")
		player_sprite.flip_h = false
		direction = Vector2.RIGHT
		
	elif Input.is_action_pressed("MoveLeft"):
		player_sprite.play("walk_side")
		player_sprite.flip_h = true
		direction = Vector2.LEFT	
		
	else:
		direction = Vector2.ZERO		
		player_sprite.stop()	
		
	velocity = direction*SPEED	
