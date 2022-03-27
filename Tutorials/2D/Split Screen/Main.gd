extends Node

# Works for max 4 players right now since I only have 4 input profiles
# If you do set it > 4 players with ids > 4 can't move..
export var num_players: int

export (PackedScene) var viewport_scene
export (PackedScene) var level_scene

onready var viewport_container = $SplitScreenContainer
onready var minimap = $MiniMap

var minimap_set = false


func _ready():
	var viewports = {}
	# Setup all viewports
	for number in range(1, num_players + 1):
		var viewport_obj = viewport_scene.instance()
		var viewport = viewport_obj.get_node("Viewport")
		viewports[number] = viewport
		viewport_container.add_child(viewport_obj)
	# Add Level to first viewport
	var level = level_scene.instance()
	level.initialize(num_players)
	viewports[1].add_child(level)
	# Set world of all viewports to firsts world
	for number in range(2, num_players + 1):
		viewports[number].world_2d = viewports[1].world_2d
	$MiniMap/Viewport.world_2d = viewports[1].world_2d
	# Set viewports camera to player based on id
	for number in range(1, num_players + 1):
		var camera = viewports[number].get_node("Camera2D")
		camera.target = level.get_node("Player%s" % number)
		set_camera_limits(level.get_node("TileMap"), camera)
	# Set player numbers (ids)
	for number in range(1, num_players + 1):
		viewports[number].get_node("UI").initialize(number)
	# Set grid columns to 1 if only one player plays
	if num_players == 1:
		viewport_container.columns = 1


func _process(_delta):
	set_minimap_viewport()


func set_minimap_viewport():
	# Set MiniMap to last viewport if num_players uneven
	if not minimap_set:
		if num_players > 1 and num_players %2 == 1:
			remove_child(minimap)
			viewport_container.add_child(minimap)
		elif num_players == 1:
			# Just a simple hack to move it out of the middle of the screen
			minimap.anchor_right = 1
		minimap_set = true


func set_camera_limits(tilemap, cam):
	var map_limits = tilemap.get_used_rect()
	var map_cellsize = tilemap.cell_size
	cam.limit_left = map_limits.position.x * map_cellsize.x
	cam.limit_right = map_limits.end.x * map_cellsize.x
	cam.limit_top = map_limits.position.y * map_cellsize.y
	cam.limit_bottom = map_limits.end.y * map_cellsize.y
