class_name FallPlayerState extends PlayerState

func enter() -> void:
	pass

func exit() -> void:
	pass

func update(delta:float) -> void:
	PLAYER.update_gravity(delta)
	PLAYER.velocity_by_input_2(PLAYERMODEL.SPEED, PLAYERMODEL.ACCELERATION, PLAYERMODEL.DECELERATION)
	PLAYER.update_velocity()
	if PLAYER.is_on_floor():
		transition.emit("IdlePlayerState")
	

func physics_update(delta:float) -> void:
	pass
