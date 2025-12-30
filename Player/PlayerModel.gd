# CharacterModel.gd
class_name PlayerModel
extends Node3D

#var velocity: Vector3 = Vector3.ZERO
const DEFAULT_SPEED:float = 5.0
@export var SPEED: float = 4.0
@export var SPRINT_SPEED: float = 6.0
@export var CROUCH_SPEED: float = 2.0
@export var JUMP_VELOCITY: float = 4.5
@export var ACCELERATION:float = 2.0
@export var DECELERATION:float = 0.45
#var is_on_floor: bool = false
#var has_moved_this_frame: bool = false
@onready var player:CharacterBody3D = $".."
@onready var SpringArm:SpringArm3D = $"../Camera/EdgeSpringArm/RearSpringArm"

func _ready() -> void:
	Global.player_model = self

func velocity_by_input(input: InputPackage, delta: float) -> Vector3:
	var new_velocity = player.velocity
	if not player.is_on_floor():
		new_velocity += player.get_gravity() * delta
	
	#para obter a camera do "helldivers" onde o player anda para onde a camera aponta, precisamos multiplicar
	#pela direção da camera, ou seja o BASIS, que retorna esse tipo de informação (posição)
	var direction := (SpringArm.basis * Vector3(input.input_direction.x, 0, input.input_direction.y)).normalized()
	#if direction:
		#new_velocity.x = direction.x * SPEED
		#new_velocity.z = direction.z * SPEED
	if direction: #em teste ainda, mas parece bom
		new_velocity.x = lerp(direction.x, direction.x * SPEED, ACCELERATION)
		new_velocity.z = lerp(direction.z, direction.z * SPEED, ACCELERATION)
	else:
		new_velocity.x = move_toward(new_velocity.x, 0, SPEED)
		new_velocity.z = move_toward(new_velocity.z, 0, SPEED)
	
	if input.is_jumping and player.is_on_floor():
		new_velocity.y += JUMP_VELOCITY
	
	return new_velocity
	
