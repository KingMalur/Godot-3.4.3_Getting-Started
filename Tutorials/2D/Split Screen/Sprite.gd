extends Sprite

var speed = 200
var dir = Vector2.RIGHT

func _process(delta):
	if position.x > get_viewport().size.x:
		dir = Vector2.LEFT
	elif position.x < 0:
		dir = Vector2.RIGHT
	
	var velocity = speed * dir
	position += velocity * delta
