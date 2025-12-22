# CharacterModel.gd
class_name CharacterModel
extends Node3D

#var velocity: Vector3 = Vector3.ZERO
var SPEED: float = 5.0
var JUMP_VELOCITY: float = 4.5
#var is_on_floor: bool = false
#var has_moved_this_frame: bool = false
@onready var player:CharacterBody3D = $".."
@onready var SpringArm:SpringArm3D = $"../SpringArm3D"

func velocity_by_input(input: InputPackage, delta: float) -> Vector3:
	#print('basis', transform.basis)
	#print('camera-basis', SpringArm.basis)
	var new_velocity = player.velocity
	if not player.is_on_floor():
		new_velocity += player.get_gravity() * delta
	
	#para obter a camera do "helldivers" onde o player anda para onde a camera aponta, precisamos multiplicar
	#pela direção da camera, ou seja o BASIS, que retorna esse tipo de informação (posição)
	var direction := (SpringArm.basis * Vector3(input.input_direction.x, 0, input.input_direction.y)).normalized()
	if direction:
		new_velocity.x = direction.x * SPEED
		new_velocity.z = direction.z * SPEED
	else:
		new_velocity.x = move_toward(new_velocity.x, 0, SPEED)
		new_velocity.z = move_toward(new_velocity.z, 0, SPEED)
	
	if input.is_jumping and player.is_on_floor():
		new_velocity.y += JUMP_VELOCITY
	
	return new_velocity
