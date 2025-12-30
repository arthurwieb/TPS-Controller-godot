extends Node3D
@export var camera_sensitivity: float = 0.01
@export_range(-90.0, 0.0, 0.1, "radians_as_degrees") var min_vertical_angle: float = -PI/2
@export_range(0.0, 90.0, 0.1, "radians_as_degrees") var max_vertical_angle: float = -PI/4
@onready var camera: Camera3D = $EdgeSpringArm/RearSpringArm/Camera3D
func _ready() -> void:
	pass
func _process(_delta: float) -> void:
	pass
	
func _unhandled_input(event: InputEvent):
	# Handle mouse input for camera rotation
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		#camera_pivot.rotate_y(deg_to_rad(-event.relative.x * camera_sensitivity))
		self.rotation.x -= event.relative.y * camera_sensitivity
		self.rotation.x = clamp(self.rotation.x, min_vertical_angle, max_vertical_angle)
		
		self.rotation.y -= event.relative.x * camera_sensitivity
		self.rotation.y = wrapf(self.rotation.y, 0.0, TAU)
