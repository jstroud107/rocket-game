extends Node2D

#1. Load the scene
var meteor_scene: PackedScene = load("res://Scenes/meteor.tscn")
var laser_scene: PackedScene = load("res://Scenes/laser.tscn")

var health: int = 3

func _ready():
	#setup health ui
	get_tree().call_group('ui', 'set_health', health)
	
	#fake meteors
	var size := get_viewport().get_visible_rect().size
	var rng := RandomNumberGenerator.new()
	for meteor in $FakeMeteors.get_children():
		# position
		var random_x = rng.randi_range(0, int(size.x))
		var random_y = rng.randi_range(0, int(size.y))
		meteor.position = Vector2(random_x, random_y)
		
		# scale
		var random_scale = rng.randf_range(0,0.25)
		meteor.scale = Vector2(random_scale,random_scale)
		
		# speed
		meteor.speed_scale = rng.randf_range(0.6,1.4)	
		

func _on_meteor_timer_timeout() -> void:
	#2. Create an instance
	var meteor = meteor_scene.instantiate()
	
	#3. Attach the node to the scene tree
	$Meteors.add_child(meteor)
	
	#connect the signal
	meteor.connect('collision', _on_meteor_collision)

func _on_meteor_collision():
	health -= 1
	get_tree().call_group('ui', 'set_health', health)
	if health <= 0:
		get_tree().change_scene_to_file("res://game_over.tscn")


func _on_player_laser(pos) -> void:
	var laser = laser_scene.instantiate()
	$Lasers.add_child(laser)
	laser.position = pos
