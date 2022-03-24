extends KinematicBody

signal hit


# How fast the player moves in meters per second
export var speed : int = 14
# The downward acceleration when in the air, in meters per second quared
export var fall_acceleration : int = 75
# Vertical impulse applied to the character upon jumping in meters per second
export var jump_impulse : int = 20
# Vertical impulse applied to the character upon bouncing over a mob in meters per second
export var bounce_impulse : int = 16


var velocity : = Vector3.ZERO


func _ready():
# warning-ignore:return_value_discarded
	$MobDetector.connect("body_entered", self, "_on_MobDetector_body_entered")


func _physics_process(delta):
	# We create a local variabl eto store the input direction
	var direction : = Vector3.ZERO
	
	# We check for each move input and update the direction accordingly
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	# We have to use z instead of y here because of 3D space
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.look_at(translation + direction, Vector3.UP)
		$AnimationPlayer.playback_speed = 4
	else:
		$AnimationPlayer.playback_speed = 1
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y += jump_impulse
	
	# Ground velocity
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	# Vertical velocity
	velocity.y -= fall_acceleration * delta
	# Moving the character
	velocity = move_and_slide(velocity, Vector3.UP)
	
	for index in range(get_slide_count()):
		# We check every collision that occured this frame
		var collision = get_slide_collision(index)
		# If we collide with a monster...
		if collision.collider.is_in_group("mob"):
			# ...we check thath we are hitting it from above
			if Vector3.UP.dot(collision.normal) > 0.1:
				# If so, we squash it and bounce
				var mob = collision.collider
				mob.squash()
				velocity.y = bounce_impulse
	
	$Pivot.rotation.x = PI / 6 * velocity.y / jump_impulse


func die():
	emit_signal("hit")
	queue_free()


func _on_MobDetector_body_entered(_body):
	die()
