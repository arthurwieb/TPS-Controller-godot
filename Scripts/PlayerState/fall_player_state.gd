class_name FallPlayerState extends PlayerState
var speed_at_entry: float = 0.0
func enter() -> void:
	#animation_state_change.emit("fall")
	var horizontal_velocity = Vector2(PLAYER.velocity.x, PLAYER.velocity.z)
	speed_at_entry = horizontal_velocity.length()
	speed_at_entry = max(speed_at_entry, PLAYERSTATS.SPEED)

func exit() -> void:
	#anim_tree["parameters/exit_fall/request"] = AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE
	pass

func update(delta:float) -> void:
	PLAYER.update_gravity(delta)
	PLAYER.velocity_by_input_2(speed_at_entry, PLAYERSTATS.ACCELERATION, PLAYERSTATS.DECELERATION, delta)
	PLAYER.update_velocity()
	
	if PLAYER.is_on_floor() && PLAYER.velocity.length() > 0.0:
		 # this does not work because walk or idle animation overlap this animation
		#animation_state_change.emit("fall_to_idle")
		transition.emit("WalkPlayerState")
	elif PLAYER.is_on_floor():
		#animation_state_change.emit("fall_to_idle") 
		transition.emit("IdlePlayerState")

func physics_update(delta:float) -> void:
	pass
