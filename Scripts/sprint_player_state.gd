class_name SprintPlayerState extends PlayerState
#@export var AnimPlayer:AnimationPlayer incluir quando tiver animações
func enter() -> void:
	#AnimPlayer.play
	PLAYERMODEL.SPEED = PLAYERMODEL.SPRINT_SPEED
	
func update(delta:float) -> void:
	pass
#func set_animation()
func _input(event: InputEvent) -> void:
	if event.is_action_released("sprint"):
		transition.emit("WalkPlayerState")
