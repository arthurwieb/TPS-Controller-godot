class_name JumpPlayerState extends PlayerState

func enter() -> void:
	animation_state_change.emit("jump")
	PLAYER.velocity.y += 5

func update(delta:float) -> void:
	PLAYER.update_gravity(delta)
	# podemos remover o controle no ar tirando essa linha ou reduzir o movimento 
	PLAYER.velocity_by_input_2(PLAYERSTATS.SPEED, PLAYERSTATS.ACCELERATION, PLAYERSTATS.DECELERATION, delta)
	PLAYER.update_velocity()
	
	if PLAYER.velocity.y < 0 && !PLAYER.is_on_floor():
		transition.emit("FallPlayerState")
	if PLAYER.is_on_floor():
		transition.emit("IdlePlayerState")
