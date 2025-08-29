extends Node3D


## Game Manager Attributes
const WORLD_SIZE = 10.0   # half width of 


## Game Manager Tools
@export var canvas_layer_path : NodePath
var canvas_layer
const ENEMY = preload("res://Scenes/Enemies/enemy.tscn")


func _ready():
	canvas_layer = get_tree().get_first_node_in_group("canvas_layer")


## Spawns enemy
func spawn_enemy():
	var enemy = ENEMY.instantiate()
	enemy.transform.origin = get_random_edge_position(0.0)
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
