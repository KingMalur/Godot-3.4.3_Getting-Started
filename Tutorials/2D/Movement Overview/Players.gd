extends Node2D

onready var player: PlayerMovement = $Player1


func select_player(number):
	if player:
		player.exit()
	
	player = get_node("Player%s" % number)
	player.enter()


func _ready():
	var _discard = $"../HUD".connect("player_selected", self, "select_player")


func _physics_process(delta):
	player.physics_process(delta)
