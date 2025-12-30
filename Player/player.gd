class_name Player extends CharacterBody3D

@onready var InputGatherer: Node = $InputGatherer
@onready var Model: Node3D = $PlayerModel
@onready var Camera: Node3D = $Camera
@onready var CROUCH_CAST:ShapeCast3D = $CrouchRayCast

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Global.player = self
	CROUCH_CAST.add_exception($".")

func _physics_process(delta):
	Global.debug.add_debug_prop("Velocity", velocity, 3)
	#var input = InputGatherer.gather_input()
	#velocity = Model.velocity_by_input(input, delta)
	#print(velocity)
	move_and_slide()
	
func velocity_by_input_2(speed: float, acceleration: float, deceleration: float) -> void:
	#print("velocity_by_input2 vel teste:", speed)
	#função teste, porque em cada state nós vamos poder usar as variavies de accel, speed, decel conforme o state
	var input_dir = Input.get_vector("left","right","forward","backward")		
	var direction := (Camera.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction: #em teste ainda, mas parece bom
		velocity.x = lerp(direction.x, direction.x * speed, acceleration)
		velocity.z = lerp(direction.z, direction.z * speed, acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration)
		velocity.z = move_toward(velocity.z, 0, deceleration)

func update_gravity(delta) -> void:
	#velocity.y -= self.get_gravity() * delta
	velocity.y -= 9.8 * delta

func update_velocity() -> void:
	move_and_slide()
