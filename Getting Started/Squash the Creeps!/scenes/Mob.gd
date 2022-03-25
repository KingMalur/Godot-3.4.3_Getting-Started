extends KinematicBody

# Emitted when the player jumped on the mob
signal squashed


# Minimum speed of the mob in meters per second
export var min_speed : int = 10
# Maximum speed of the mob in meters per second
export var max_speed : int = 18

var velocity : = Vector3.ZERO


func _physics_process(_delta):
	move_and_slide(velocity)
	transform.origin.y = 0

# We will call this function from the main scene
func initialize(start_position, player_position):
	translation = start_position
	# Set players y position to 0 so the mobs don't look up into the sky
	player_position.y = 0
	# We turn the mob so it looks at the player
	look_at(player_position, Vector3.UP)
	# And rotate it randomly so it doesn't move exactly towards the player
	rotate_y(rand_range(-PI / 4, PI / 4))
	
	# We calculate a random speed
	var random_speed : float = rand_range(min_speed, max_speed)
	# We calculate a forward velocity that represents the mob speed
	velocity = Vector3.FORWARD * random_speed
	# We then rotate the vector based on the mob's Y rotation to move in the direction it's looking
	velocity = velocity.rotated(Vector3.UP, rotation.y)
	
	# Set a random animation speed to make every mob feel unique
	$AnimationPlayer.playback_speed = random_speed / min_speed


func squash():
	emit_signal("squashed")
	queue_free()


func _on_VisibilityNotifier_screen_exited():
	queue_free()
