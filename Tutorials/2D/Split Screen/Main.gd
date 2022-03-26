extends Node

onready var viewport1 = $SplitScreenContainer/ViewportContainer1/Viewport1
onready var viewport2 = $SplitScreenContainer/ViewportContainer2/Viewport2
onready var camera1 = $SplitScreenContainer/ViewportContainer1/Viewport1/Camera2D1
onready var camera2 = $SplitScreenContainer/ViewportContainer2/Viewport2/Camera2D2
onready var world = $SplitScreenContainer/ViewportContainer1/Viewport1/Level
onready var button1 = $SplitScreenContainer/ViewportContainer1/Viewport1/UI
onready var button2 = $SplitScreenContainer/ViewportContainer2/Viewport2/UI


func _ready():
	viewport2.world_2d = viewport1.world_2d
	$MiniMap/Viewport.world_2d = viewport1.world_2d
	
	button1.player_id = world.get_node("Player1").player
	button2.player_id = world.get_node("Player2").player
	
	camera1.target = world.get_node("Player1")
	camera2.target = world.get_node("Player2")
	set_camera_limits()


func set_camera_limits():
	var tilemap = world.get_node("TileMap")
	var map_limits = tilemap.get_used_rect()
	var map_cellsize = tilemap.cell_size
	for cam in [camera1, camera2]:
		cam.limit_left = map_limits.position.x * map_cellsize.x
		cam.limit_right = map_limits.end.x * map_cellsize.x
		cam.limit_top = map_limits.position.y * map_cellsize.y
		cam.limit_bottom = map_limits.end.y * map_cellsize.y
