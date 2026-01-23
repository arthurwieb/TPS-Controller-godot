extends Node3D
class_name PlayerModel
var current_mouse_rotation: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_camera_mouse_rotated(_rotation: Vector2) -> void:
	current_mouse_rotation = _rotation
	transform.basis = Basis()
	rotate_object_local(Vector3(0, 1, 0), current_mouse_rotation.x)
