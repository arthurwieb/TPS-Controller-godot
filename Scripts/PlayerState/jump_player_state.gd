class_name JumpPlayerState extends PlayerState
var speed_at_entry: float = 0.0

func enter() -> void:
	animation_state_change.emit("jump")
	PLAYER.velocity.y += 5
	# Create a 2D vector from the horizontal axes (X and Z)
	var horizontal_velocity = Vector2(PLAYER.velocity.x, PLAYER.velocity.z)
	# The .length() gives us the actual magnitude of our movement on the floor
	speed_at_entry = horizontal_velocity.length()
	# Safety check: ensure the air speed isn't lower than base movement
	speed_at_entry = max(speed_at_entry, PLAYERSTATS.SPEED)

func update(delta:float) -> void:	
	PLAYER.update_gravity(delta)
	# podemos remover o controle no ar tirando essa linha ou reduzir o movimento 
	PLAYER.velocity_by_input_2(speed_at_entry, PLAYERSTATS.ACCELERATION, PLAYERSTATS.DECELERATION, delta)
	PLAYER.update_velocity()
	
	if PLAYER.velocity.y < 0 && !PLAYER.is_on_floor():
		transition.emit("FallPlayerState")
	if PLAYER.is_on_floor():
		transition.emit("IdlePlayerState")
