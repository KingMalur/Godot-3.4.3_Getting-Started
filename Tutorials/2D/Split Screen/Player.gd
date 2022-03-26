extends Sprite

var speed = 200

var move_right = "p%s_move_right"
var move_left = "p%s_move_left"
var move_up = "p%s_move_up"
var move_down = "p%s_move_down"

enum Player_Selection { P1 = 1, P2 = 2}
export (Player_Selection) var player


func assign_controls():
	move_right %= player
	move_left %= player
	move_up %= player
	move_down %= player


func _ready():
	assign_controls()
	$Label.text %= player
	print ("Player %s" %player + " ready!")


func _process(delta):
	var dir = Vector2.ZERO
	if Input.is_action_pressed(move_right):
		dir.x = 1
	if Input.is_action_pressed(move_left):
		dir.x = -1
	if Input.is_action_pressed(move_up):
		dir.y = -1
	if Input.is_action_pressed(move_down):
		dir.y = 1
	
	position += dir.normalized() * speed * delta
