class_name Player extends CharacterBody3D

@onready var InputGatherer: Node = $InputGatherer
@onready var Camera: Node3D = $Camera
@onready var CROUCH_CAST:ShapeCast3D = $CrouchRayCast
@export var player_model:Node3D
var camera_T:float

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Global.player = self
	CROUCH_CAST.add_exception($".")

func _physics_process(_delta):
	Global.debug.add_debug_prop("Velocity", velocity, 1)
	#var input = InputGatherer.gather_input()
	#velocity = Model.velocity_by_input(input, delta)
	#print(velocity)
	if Input.is_action_pressed("release_mouse"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	move_and_slide()
	
func velocity_by_input_2(speed: float, acceleration: float, deceleration: float, delta: float) -> void:
	var input_dir = Input.get_vector("left", "right", "forward", "backward")

	# Get the camera's forward and right vectors, but kill the vertical (Y) part
	var forward = Camera.global_transform.basis.z
	var right = Camera.global_transform.basis.x

	forward.y = 0
	right.y = 0

	# Combine them based on input
	var direction = (right * input_dir.x + forward * input_dir.y).normalized()

	if direction != Vector3.ZERO:
		# Create a target velocity vector
		var target_velocity = direction * speed
		# Calculate horizontal velocity only (ignoring current Y/gravity)
		var horizontal_vel = Vector3(velocity.x, 0, velocity.z)
		horizontal_vel = horizontal_vel.lerp(target_velocity, acceleration * delta)

		velocity.x = horizontal_vel.x
		velocity.z = horizontal_vel.z
		
		rotate_armature(Vector2(direction.x, direction.z), delta)
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration * delta)
		velocity.z = move_toward(velocity.z, 0, deceleration * delta)

func update_gravity(delta) -> void:
	#velocity.y -= self.get_gravity() * delta
	velocity.y -= 9.8 * delta # dar um jeito de pegar a gravity do projeto

func update_velocity() -> void:
	move_and_slide()

#11:07 min mark
func rotate_armature(angle: Vector2, delta, _offset: float = 0) -> void:
	var new_angle: float = atan2(angle.x, angle.y)	
	player_model.rotation.y = lerp_angle(
		player_model.rotation.y,
		new_angle,
		20*delta
	)
