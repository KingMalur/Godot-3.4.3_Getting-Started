extends Node

export (PackedScene) var player_scene


func initialize(num_players):
	for number in range(1, num_players + 1):
		var player = player_scene.instance()
		player.name = "Player%s" % number
		player.id = number
		add_child(player)
