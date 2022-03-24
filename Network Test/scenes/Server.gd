extends Node


func _ready():
	var peer = NetworkedMultiplayerENet.new()
	var result = peer.create_server(5555, 32)
	get_tree().set_network_peer(peer)
	# Connect signals for connect & disconnect of players
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	
	print("Server waiting for connections...")


func _player_connected(id):
	print("Callback: _player_connected:", id)


func _player_disconnected(id):
	print("Callback: _player_disconnected:", id)


remote func register_player(id, player_info):
	print("Remote: register_player(" + str(id) + ", " + str(player_info) + ")")
