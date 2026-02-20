extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
@export var anim_tree : AnimationTree
@onready var anim_tree_states = anim_tree["parameters/playback"]
#var is_jumping:bool = false
#var is_falling:bool = false

func _physics_process(delta: float) -> void:
	#ignore actions name, they just trigger the if block
	if Input.is_action_just_pressed("jump"):
		anim_tree_states.set("parameters/conditions/is_jumping", true)
		anim_tree_states.travel("jump_run")
	if Input.is_action_just_pressed("forward"):
		anim_tree_states.set("parameters/conditions/is_jumping", false)
		anim_tree_states.set("parameters/conditions/is_falling", true)
		anim_tree_states.travel("falling")
	if Input.is_action_just_pressed("backward"):
		anim_tree_states.set("parameters/conditions/is_jumping", false)
		anim_tree_states.set("parameters/conditions/is_falling", false)
		anim_tree_states.travel("fall_to_idle")
