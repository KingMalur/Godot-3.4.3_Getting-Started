extends Sprite


export var pulse_time: float = 1.0
var current_pulse: float = 0.0


func _process(delta):
	current_pulse += delta
	if current_pulse > pulse_time:
		current_pulse = 0.0
		visible = not visible
