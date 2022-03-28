extends PlayerMovement

export (int) var speed = 200

var velocity = Vector2()


func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("right_1"):
		velocity.x += 1
	if Input.is_action_pressed("left_1"):
		velocity.x -= 1
	if Input.is_action_pressed("up_1"):
		velocity.y -= 1
	if Input.is_action_pressed("down_1"):
		velocity.y += 1
	velocity = velocity.normalized() * speed


func physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)


func enter():
	velocity = Vector2()


func exit():
	velocity = Vector2()
