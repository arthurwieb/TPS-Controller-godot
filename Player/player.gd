extends CharacterBody3D

@onready var InputGatherer: Node = $InputGatherer
@onready var PlayerModel: Node3D = $PlayerModel

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Global.player = self

func _physics_process(delta):
	var input = InputGatherer.gather_input()
	velocity = PlayerModel.velocity_by_input(input, delta)
	#print(velocity)
	move_and_slide()
