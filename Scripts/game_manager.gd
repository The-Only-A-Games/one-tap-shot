extends Node3D


## Game Manager Attributes
const WORLD_SIZE = 10.0   # half width of 


## Game Manager Tools
@export var canvas_layer_path : NodePath
const ENEMY = preload("res://Scenes/Enemies/enemy.tscn")
var canvas_layer
var timer
const SPAWN = preload("res://Scenes/spawn.tscn")

func _ready():
	get_tree().paused = false
	canvas_layer = get_tree().get_first_node_in_group("canvas_layer")
	timer = get_tree().get_first_node_in_group("time")


func _physics_process(delta):
	
	match canvas_layer.get_score():
		20:
			timer.wait_time = 1.0
		50:
			timer.wait_time = 0.8
		150:
			timer.wait_time = 0.5
		300:
			timer.wait_time = 0.2


## Spawns enemy
func spawn_enemy():
	var spawn = SPAWN.instantiate()
	var enemy = ENEMY.instantiate()
	
	var random_position = get_random_edge_position(0.0)
	enemy.transform.origin = random_position
	spawn.transform.origin = random_position
	add_child(spawn)
	
	spawn.spawn()
	
	await get_tree().create_timer(1.3).timeout
	add_child(enemy)


## Finds a random edge position
func get_random_edge_position(y: float = 0.0) -> Vector3:
	var side = randi() % 4 # get random edge to spawn in
	var x = 0.0
	var z = 0.0
	
	match side:
		0:  # left edge
			x = -WORLD_SIZE
			z = randf_range(-WORLD_SIZE, WORLD_SIZE)
		1:  # right edge
			x = WORLD_SIZE
			z = randf_range(-WORLD_SIZE, WORLD_SIZE)
		2:  # top edge
			x = randf_range(-WORLD_SIZE, WORLD_SIZE)
			z = -WORLD_SIZE
		3:  # bottom edge
			x = randf_range(-WORLD_SIZE, WORLD_SIZE)
			z = WORLD_SIZE
	
	return Vector3(x, y, z)


## Spawns enemies at random position when the timer runs out
func _on_timer_timeout():
	# Keep spawning as long as the player is alive
	if canvas_layer.get_health() > 0:
		spawn_enemy()
