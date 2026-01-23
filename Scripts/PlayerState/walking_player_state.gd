class_name WalkPlayerState extends PlayerState
func enter() -> void:
	animation_state_change.emit("walk")
	PLAYERSTATS.SPEED = PLAYERSTATS.DEFAULT_SPEED

func update(delta:float) -> void:
	PLAYER.update_gravity(delta)
	PLAYER.velocity_by_input_2(PLAYERSTATS.SPEED, PLAYERSTATS.ACCELERATION, PLAYERSTATS.DECELERATION, delta)
	PLAYER.update_velocity()
	
	if PLAYER.velocity.length() == 0.0:
		transition.emit("IdlePlayerState")
	if Input.is_action_pressed("sprint") && PLAYER.is_on_floor():
		transition.emit("SprintPlayerState")
	if Input.is_action_pressed("crouch") && PLAYER.is_on_floor():
		transition.emit("CrouchPlayerState")
	if Input.is_action_just_pressed("jump") && PLAYER.is_on_floor():
		transition.emit("JumpPlayerState")
	if PLAYER.velocity.y < 0 && !PLAYER.is_on_floor():
		transition.emit("FallPlayerState")
