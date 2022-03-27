extends Sprite

var speed = 200

var move_right = "p%s_move_right"
var move_left = "p%s_move_left"
var move_up = "p%s_move_up"
var move_down = "p%s_move_down"

var has_move_right = false
var has_move_left = false
var has_move_up = false
var has_move_down = false

var id = 0


func assign_controls():
	move_right %= id
	move_left %= id
	move_up %= id
	move_down %= id
	
	if InputMap.get_actions().has(move_right):
		has_move_right = true
	if InputMap.get_actions().has(move_left):
		has_move_left = true
	if InputMap.get_actions().has(move_up):
		has_move_up = true
	if InputMap.get_actions().has(move_down):
		has_move_down = true


func _ready():
	assign_controls()
	$Label.text %= id
	print ("Player %s" %id + " ready!")


func _process(delta):
	var dir = Vector2.ZERO
	if has_move_right and Input.is_action_pressed(move_right):
		dir.x = 1
	if has_move_left and Input.is_action_pressed(move_left):
		dir.x = -1
	if has_move_up and Input.is_action_pressed(move_up):
		dir.y = -1
	if has_move_down and Input.is_action_pressed(move_down):
		dir.y = 1
	
	position += dir.normalized() * speed * delta
