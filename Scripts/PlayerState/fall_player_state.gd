class_name FallPlayerState extends PlayerState

func enter() -> void:
	animation_state_change.emit("fall")
	pass

func exit() -> void:
	pass

func update(delta:float) -> void:
	PLAYER.update_gravity(delta)
	PLAYER.velocity_by_input_2(PLAYERSTATS.SPEED, PLAYERSTATS.ACCELERATION, PLAYERSTATS.DECELERATION, delta)
	PLAYER.update_velocity()
	if PLAYER.is_on_floor():
		transition.emit("IdlePlayerState")
	

func physics_update(delta:float) -> void:
	pass
