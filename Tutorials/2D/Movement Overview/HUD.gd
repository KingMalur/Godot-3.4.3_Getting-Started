extends Control

signal player_selected(number)

onready var checkbox_player1 = $PlayerSelection/CheckBox1
onready var checkbox_player2 = $PlayerSelection/CheckBox2
onready var checkbox_player3 = $PlayerSelection/CheckBox3
onready var checkbox_player4 = $PlayerSelection/CheckBox4


func _ready():
	checkbox_player1.connect("pressed", self, "_on_Checkbox_Pressed", [ 1 ])
	checkbox_player2.connect("pressed", self, "_on_Checkbox_Pressed", [ 2 ])
	checkbox_player3.connect("pressed", self, "_on_Checkbox_Pressed", [ 3 ])
	checkbox_player4.connect("pressed", self, "_on_Checkbox_Pressed", [ 4 ])


func _on_Checkbox_Pressed(number):
	print("Checkbox no. %s pressed" % number)
	emit_signal("player_selected", number)
