class_name CrouchPlayerState extends PlayerState
func enter() -> void:
	#ANIMPLAYER.play("Crouch")
	animation_state_change.emit("walk")

func exit() -> void:
	#ANIMPLAYER.play_backwards("Crouch")
	pass

func update(delta:float) -> void:
	PLAYER.update_gravity(delta)
	PLAYER.velocity_by_input_2(PLAYERSTATS.CROUCH_SPEED, PLAYERSTATS.ACCELERATION, PLAYERSTATS.DECELERATION, delta)
	PLAYER.update_velocity()
	if Input.is_action_just_released("crouch"):
		uncrouch()

func uncrouch():
	print("unc")
	if !PLAYER.CROUCH_CAST.is_colliding() && !Input.is_action_pressed("crouch"):
		transition.emit("IdlePlayerState")
	elif PLAYER.CROUCH_CAST.is_colliding():
		await get_tree().create_timer(0.1).timeout
		uncrouch()
	
func physics_update(delta:float) -> void:
	pass
