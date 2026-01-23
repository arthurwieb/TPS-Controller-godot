extends Node3D
signal mouse_rotated(_rotation: Vector2)
@export var camera_sensitivity: float = 0.01
@export var rearSpringArm: SpringArm3D
@export var edgeSpringArm: SpringArm3D

@export_range(-90.0, 0.0, 0.1, "radians_as_degrees") var min_vertical_angle: float = -PI/2
@export_range(0.0, 90.0, 0.1, "radians_as_degrees") var max_vertical_angle: float = -PI/4
@onready var camera: Camera3D = $EdgeSpringArm/RearSpringArm/Camera3D
@onready var default_spring_arm_length:float = edgeSpringArm.spring_length

var camera_tween: Tween
func _ready() -> void:
	pass
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("swap_camera"):
		swap_camera_alignment()
		
# essa func precisa virar um "camera_look"
func _unhandled_input(event: InputEvent): 
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		#camera_pivot.rotate_y(deg_to_rad(-event.relative.x * camera_sensitivity))
		self.rotation.x -= event.relative.y * camera_sensitivity
		self.rotation.x = clamp(self.rotation.x, min_vertical_angle, max_vertical_angle)
		
		self.rotation.y -= event.relative.x * camera_sensitivity
		self.rotation.y = wrapf(self.rotation.y, 0.0, TAU)
		mouse_rotated.emit(event)

func swap_camera_alignment():
	default_spring_arm_length = -default_spring_arm_length
	set_spring_arm_position(default_spring_arm_length, 0.2)
	
func set_spring_arm_position(pos:float, speed:float) -> void:
	if camera_tween:
		camera_tween.kill()
	camera_tween = get_tree().create_tween()
	camera_tween.tween_property(edgeSpringArm, "spring_length", pos, speed)
