class_name JumpPlayerState extends State

func enter() -> void:
	pass

func update(delta:float) -> void:
	print(Global.player.velocity.y)
	if Global.player.velocity.y > 0:
		transition.emit("JumpPlayerState")
