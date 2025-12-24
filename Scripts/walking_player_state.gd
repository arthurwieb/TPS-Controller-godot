class_name WalkPlayerState extends PlayerState
func enter() -> void:
		PLAYERMODEL.SPEED = PLAYERMODEL.DEFAULT_SPEED

func update(delta:float) -> void:
	if PLAYER.velocity.length() == 0.0:
		transition.emit("IdlePlayerState")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("sprint") && PLAYER.is_on_floor():
		transition.emit("SprintPlayerState")
