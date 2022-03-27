extends Panel

export (PackedScene) var logo_scene

var global_position


func _ready():
	var local_pos = Vector2(10, 20) # Local to UI/CanvasLayer2
	var ie = InputEventMouseButton.new()
	ie.button_index = BUTTON_LEFT
	global_position = get_viewport_transform() * (get_global_transform() * local_pos)
	ie.position = global_position
	get_tree().input_event(ie)
	print("Clicked on position " + str(ie.position) + " based on local position " + str(local_pos))
	
	var logo = logo_scene.instance()
	logo.position = local_pos
	add_child(logo)


func _process(_delta):
	if global_position.x < OS.window_size.x and global_position.y < OS.window_size.y:
		var logo = logo_scene.instance()
		global_position += Vector2(150, 0)
		logo.position = global_position
		get_parent().add_child(logo)
