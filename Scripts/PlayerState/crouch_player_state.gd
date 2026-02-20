class_name CrouchPlayerState extends PlayerState
func enter() -> void:
	#ANIMPLAYER.play("Crouch")
	animation_state_change.emit("crouch")

func exit() -> void:
	print('sai')
	animation_state_change.emit("crouch_to_stand")
	pass

func update(delta:float) -> void:	
	PLAYER.update_gravity(delta)
	PLAYER.velocity_by_input_2(PLAYERSTATS.CROUCH_SPEED, PLAYERSTATS.ACCELERATION, PLAYERSTATS.DECELERATION, delta)
	PLAYER.update_velocity()
	#if Input.is_action_pressed("forward") && PLAYER.is_on_floor():		
		#transition.emit("CrouchWalkPlayerState")
	if PLAYER.velocity.length() > 0.0 && PLAYER.is_on_floor():
		animation_state_change.emit("crouch_walk")
	else:
		animation_state_change.emit("crouch")
	
	if Input.is_action_just_released("crouch"):
		uncrouch()

func uncrouch():
	print("unc")	
	if !PLAYER.CROUCH_CAST.is_colliding() && !Input.is_action_pressed("crouch"):
		transition.emit("IdlePlayerState")
	elif !PLAYER.CROUCH_CAST.is_colliding() && !Input.is_action_pressed("crouch") && PLAYER.velocity.length() > 0.0 && PLAYER.is_on_floor():
		transition.emit("WalkPlayerState")
	elif PLAYER.CROUCH_CAST.is_colliding():
		await get_tree().create_timer(0.1).timeout
		uncrouch()
	
func physics_update(delta:float) -> void:
	pass
