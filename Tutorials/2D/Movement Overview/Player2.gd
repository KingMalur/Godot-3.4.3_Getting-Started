extends PlayerMovement

export (int) var speed = 200
export (float) var rotation_speed = 1.5

var velocity = Vector2()
var rotation_dir = 0


func get_input():
	rotation_dir = 0
	velocity = Vector2()
	if Input.is_action_pressed("right_2"):
		rotation_dir += 1
	if Input.is_action_pressed("left_2"):
		rotation_dir -= 1
	if Input.is_action_pressed("up_2"):
		velocity = Vector2(0, -speed).rotated(rotation)
	if Input.is_action_pressed("down_2"):
		velocity = Vector2(0, speed).rotated(rotation)


func physics_process(delta):
	get_input()
	rotation += rotation_dir * rotation_speed * delta
	velocity = move_and_slide(velocity)


func enter():
	velocity = Vector2()
	rotation_dir = 0


func exit():
	velocity = Vector2()
	rotation_dir = 0
