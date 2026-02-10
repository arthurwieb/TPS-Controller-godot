class_name FallPlayerState extends PlayerState
var speed_at_entry: float = 0.0
func enter() -> void:
	animation_state_change.emit("fall")
	# Create a 2D vector from the horizontal axes (X and Z)
	var horizontal_velocity = Vector2(PLAYER.velocity.x, PLAYER.velocity.z)
	# The .length() gives us the actual magnitude of our movement on the floor
	speed_at_entry = horizontal_velocity.length()
	
	# Safety check: ensure the air speed isn't lower than base movement
	speed_at_entry = max(speed_at_entry, PLAYERSTATS.SPEED)
	print(horizontal_velocity,speed_at_entry)	
	pass

func exit() -> void:
	pass

func update(delta:float) -> void:
	PLAYER.update_gravity(delta)
	PLAYER.velocity_by_input_2(speed_at_entry, PLAYERSTATS.ACCELERATION, PLAYERSTATS.DECELERATION, delta)
	PLAYER.update_velocity()
	if PLAYER.is_on_floor():
		transition.emit("IdlePlayerState")
	

func physics_update(delta:float) -> void:
	pass
