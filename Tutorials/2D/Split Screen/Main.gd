extends Node

export (PackedScene) var viewport_scene
export (PackedScene) var level_scene

onready var viewport1 = $SplitScreenContainer/ViewportContainer1/Viewport1
onready var viewport2 = $SplitScreenContainer/ViewportContainer2/Viewport2
onready var camera1 = $SplitScreenContainer/ViewportContainer1/Viewport1/Camera2D1
onready var camera2 = $SplitScreenContainer/ViewportContainer2/Viewport2/Camera2D2
onready var world = $SplitScreenContainer/ViewportContainer1/Viewport1/Level
onready var button1 = $SplitScreenContainer/ViewportContainer1/Viewport1/UI
onready var button2 = $SplitScreenContainer/ViewportContainer2/Viewport2/UI

onready var viewport_container = $SplitScreenContainer

func _ready():
	var level_node
	for number in [1, 2]:
		var viewport = viewport_scene.instance()
		var viewport_root = viewport.get_node("Viewport")
		
		if number == 1:
			var level = level_scene.instance()
			viewport_root.add_child(level)
			level_node = viewport_root
			$MiniMap/Viewport.world_2d = viewport_root.world_2d
		else:
			viewport_root.world_2d = level_node.world_2d
			
		var player = viewport_root.get_node("Player%s" % number)
		var button = viewport.get_node("UI")
		#button.player = number
		
		viewport_container.add_child(viewport)
	
	#button1.player_id = world.get_node("Player1").player
	#button2.player_id = world.get_node("Player2").player
	
	#camera1.target = world.get_node("Player1")
	#camera2.target = world.get_node("Player2")
	#set_camera_limits()


func set_camera_limits():
	var tilemap = world.get_node("TileMap")
	var map_limits = tilemap.get_used_rect()
	var map_cellsize = tilemap.cell_size
	for cam in [camera1, camera2]:
		cam.limit_left = map_limits.position.x * map_cellsize.x
		cam.limit_right = map_limits.end.x * map_cellsize.x
		cam.limit_top = map_limits.position.y * map_cellsize.y
		cam.limit_bottom = map_limits.end.y * map_cellsize.y
