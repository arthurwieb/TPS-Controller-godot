class_name SprintPlayerState extends PlayerState
#@export var AnimPlayer:AnimationPlayer incluir quando tiver animações
func enter() -> void:
	#AnimPlayer.play
	#PLAYERMODEL.SPEED = PLAYERMODEL.SPRINT_SPEED
	print('entrei no sprint')
	pass
	
func update(delta:float) -> void:
	PLAYER.update_gravity(delta)
	PLAYER.velocity_by_input_2(PLAYERMODEL.SPRINT_SPEED, PLAYERMODEL.ACCELERATION, PLAYERMODEL.DECELERATION)
	PLAYER.update_velocity()
	
	if Input.is_action_just_released("sprint"):
		transition.emit("WalkPlayerState")
	if Input.is_action_just_pressed("jump") && PLAYER.is_on_floor():
		transition.emit("JumpPlayerState")
	
#func set_animation()
