class_name PlayerState extends State 
var PLAYER: Player
#var PLAYERMODEL: PlayerModel #deprecated se possível
var ANIMPLAYER: AnimationPlayer
#@onready var ANIMTREE: AnimationTree = $PlayerModel/AnimationTree
@export var PLAYERMODEL: PlayerModel
@export var PLAYERSTATS: PlayerStats = preload("res://Player/PlayerStatsResource.tres")

func _ready() -> void:
	print(PLAYERSTATS)
	await owner.ready
	PLAYER = owner as Player #owner é o characterController
	#PLAYERMODEL = PLAYER.get_node("PlayerModel") as PlayerModel
	ANIMPLAYER = PLAYER.get_node("AnimationPlayer") as AnimationPlayer
	
func _process(delta: float) -> void:
	pass
