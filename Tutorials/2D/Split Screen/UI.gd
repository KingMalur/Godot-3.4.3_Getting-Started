extends Control

var player_id = 0


func _ready():
	var viewport = get_parent()
	$CanvasLayer_UI/Button.connect("button_up", self, "_on_Button_button_up")


func _on_Button_button_up():
	print("Button for Player %s pressed!" % player_id)
