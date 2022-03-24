extends Control


func _ready():
	$ClientButton.connect("button_up", self, "_on_ClientButton_button_up")
	$ServerButton.connect("button_up", self, "_on_ServerButton_button_up")


func _on_ClientButton_button_up():
	get_tree().change_scene("res://scenes/Client.tscn")


func _on_ServerButton_button_up():
	get_tree().change_scene("res://scenes/Server.tscn")
