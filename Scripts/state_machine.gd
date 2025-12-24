class_name StateMachine extends Node
@export var CURRENT_STATE: State
var states: Dictionary = {}
func _ready():
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.transition.connect(on_child_transition)
		else:
			push_warning("6778: State não encontrado")
	if !owner.is_node_ready():
		await owner.ready
	if CURRENT_STATE:
		CURRENT_STATE.enter()

func _process(delta: float) -> void:
	CURRENT_STATE.update(delta)
	Global.debug.add_debug_prop("Current State", CURRENT_STATE.name, 2)
	
func _physics_process(delta: float) -> void:
	CURRENT_STATE.physics_update(delta)

func on_child_transition(new_state_name:StringName) -> void:
	var new_state = states.get(new_state_name)
	if new_state != null:
		if new_state != CURRENT_STATE:
			CURRENT_STATE.exit()
			new_state.enter()
			CURRENT_STATE = new_state
	else:
		push_warning("State does not exists")
