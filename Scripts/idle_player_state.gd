class_name IdlePlayerState extends PlayerState


func update(delta:float) -> void:
	if PLAYER.velocity.length() > 0.0 && PLAYER.is_on_floor():
		transition.emit("WalkPlayerState")
