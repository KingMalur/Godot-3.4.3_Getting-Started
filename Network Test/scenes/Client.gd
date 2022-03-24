extends Node


func _ready():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client("127.0.0.1", 5555)
	get_tree().set_network_peer(peer)
	# Connect signals of server & connection to server
	get_tree().connect("connected_to_server", self, "_client_connected_ok")
	get_tree().connect("connection_failed", self, "_connection_failed")
	get_tree().connect("server_disconnected", self, "_server_disconnected")
	
	print("Client connected")

func _client_connected_ok():
	var my_info = { name = "Player", color = "Red" }
	rpc_id(1, "register_player", get_tree().get_network_unique_id(), my_info)
	
	print("Callback: _client_connected_ok")


func _connection_failed():
	print("Callback: _connection_failed")


func _server_disconnected():
	print("Callback: _server_disconnected")
