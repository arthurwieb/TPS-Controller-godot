class_name Player extends CharacterBody3D

@onready var InputGatherer: Node = $InputGatherer
@onready var Model: Node3D = $PlayerModel

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Global.player = self

func _physics_process(delta):
	Global.debug.add_debug_prop("Velocity", velocity, 3)
	var input = InputGatherer.gather_input()
	velocity = Model.velocity_by_input(input, delta)
	#print(velocity)
	move_and_slide()
