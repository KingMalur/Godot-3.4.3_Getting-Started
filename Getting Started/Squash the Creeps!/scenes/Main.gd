extends Node

export (PackedScene) var mob_scene : PackedScene


func _ready():
	$MobTimer.connect("timeout", self, "_on_MobTimer_timeout")
	$Player.connect("hit", self, "_on_Player_hit")
	$UserInterface/Retry.hide()
	randomize()


func _on_MobTimer_timeout():
	# Create a Mob instance and add it to the scene
	var mob : Node = mob_scene.instance()
	
	# Choose a random location on Path2D
	# Store the reference to the SpawnLocation node
	var mob_spawn_location : Node = get_node("SpawnPath/SpawnLocation")
	# And give it a random offset
	mob_spawn_location.unit_offset = randf()
	
	var player_position = $Player.transform.origin
	
	add_child(mob)
	mob.initialize(mob_spawn_location.translation, player_position)
	
	# We connect the mob to the score label to update the score upon squashing one
	mob.connect("squashed", $UserInterface/ScoreLabel, "_on_Mob_squashed")


func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and $UserInterface/Retry.visible:
		# This restarts the current scene
		get_tree().reload_current_scene()


func _on_Player_hit():
	$MobTimer.stop()
	$UserInterface/Retry.show()
