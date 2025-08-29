extends Node3D

@export var canvas_layer_path : NodePath
var canvas_layer
const WORLD_SIZE = 10.0   # half width of 
const ENEMY = preload("res://Scenes/Enemies/enemy.tscn")

var count = 0

func _ready():
	canvas_layer = get_node(canvas_layer_path)


#func _physics_process(delta):
	#count += 1
	
	#if count <= 5:
		#spawn_enemy()

func spawn_enemy():
	var enemy = ENEMY.instantiate()
	enemy.transform.origin = get_random_edge_position(0.0)
	add_child(enemy)

func get_random_edge_position(y: float = 0.0) -> Vector3:
	var side = randi() % 4
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


func _on_timer_timeout():
	spawn_enemy()
