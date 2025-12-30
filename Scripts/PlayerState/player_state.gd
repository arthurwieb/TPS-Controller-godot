class_name PlayerState extends State 
var PLAYER: Player
var PLAYERMODEL: PlayerModel
var ANIMPLAYER: AnimationPlayer

func _ready() -> void:
	await owner.ready
	PLAYER = owner as Player #owner é o characterController
	PLAYERMODEL = PLAYER.get_node("PlayerModel") as PlayerModel
	ANIMPLAYER = PLAYER.get_node("AnimationPlayer") as AnimationPlayer
	
func _process(delta: float) -> void:
	pass
