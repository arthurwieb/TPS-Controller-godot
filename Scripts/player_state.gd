class_name PlayerState extends State 
var PLAYER: Player
var PLAYERMODEL: PlayerModel
var AnimPlayer: AnimationPlayer
func _ready() -> void:
	await owner.ready
	PLAYER = owner as Player
	PLAYERMODEL = PLAYER.get_node("PlayerModel") as PlayerModel
	
	#AnimPlayer = Player.animationPlayer
	
func _process(delta: float) -> void:
	pass
