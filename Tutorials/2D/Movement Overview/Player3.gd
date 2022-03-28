extends PlayerMovement

export(int) var speed = 200

var velocity = Vector2()


func get_input():
	look_at(get_global_mouse_position())
	# Add 90 degrees to rotation so the sprite is rotated correctly
	rotation_degrees += 90
	
	velocity = Vector2()
	if Input.is_action_pressed("up_3"):
		velocity = Vector2(0, -speed).rotated(rotation)
	if Input.is_action_pressed("down_3"):
		velocity = Vector2(0, speed).rotated(rotation)


func physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)


func enter():
	velocity = Vector2()


func exit():
	velocity = Vector2()
