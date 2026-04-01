class_name State extends Node
signal transition(new_state_name:String)
#signal animation_state_change(state:String)
signal finished(next_state:String)
func enter() -> void:
	pass

func exit() -> void:
	pass

func update(delta:float) -> void:
	pass

func physics_update(delta:float) -> void:
	pass
