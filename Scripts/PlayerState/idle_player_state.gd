class_name IdlePlayerState extends PlayerState
func enter() -> void:
	animation_state_change.emit("idle")
	pass
	
func update(delta:float) -> void:
	PLAYER.update_gravity(delta)
	PLAYER.velocity_by_input_2(PLAYERSTATS.SPEED, PLAYERSTATS.ACCELERATION, PLAYERSTATS.DECELERATION, delta)
	PLAYER.update_velocity()
	
	if PLAYER.velocity.length() > 0.0 && PLAYER.is_on_floor():
		transition.emit("WalkPlayerState")
	
	if Input.is_action_pressed("crouch") && PLAYER.is_on_floor():
		transition.emit("CrouchPlayerState")
		
	if Input.is_action_just_pressed("jump") && PLAYER.is_on_floor():
		transition.emit("JumpPlayerState")
	if PLAYER.velocity.y < 0 && !PLAYER.is_on_floor():
		transition.emit("FallPlayerState")
