extends PlayerMovement

export (int) var speed = 200

var target = Vector2()
var velocity = Vector2()

var process_allowed = false


func _input(event):
	if event.is_action_pressed("click_4"):
		target = get_global_mouse_position()


func physics_process(_delta):
	if not process_allowed:
		return
	
	velocity = position.direction_to(target) * speed
	look_at(target)
	# Add 90 degrees to rotation so the sprite is rotated correctly
	rotation_degrees += 90
	
	if position.distance_to(target) > 5:
		velocity = move_and_slide(velocity)


func enter():
	velocity = Vector2()
	process_allowed = true


func exit():
	process_allowed = false
	velocity = Vector2()
