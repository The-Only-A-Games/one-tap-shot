extends CharacterBody3D


## Player Stats

@onready var marker = %Marker3D
const PLAYER_PROJECTILE = preload("res://Scenes/Projectiles/player_projectile.tscn")
var canvas_layer
var camera

func _ready():
	canvas_layer = get_tree().get_first_node_in_group("canvas_layer")
	camera = get_tree().get_first_node_in_group("camera")


func _physics_process(delta):
	if canvas_layer.get_health() <= 0.0:
		canvas_layer.game_over_screen()
	
	rotate_toward_mouse()
	
	if Input.is_action_just_pressed("shoot"):
		var enemy = get_closest_enemy()
		
		if enemy != null:
			var target_pos = enemy.global_transform.origin
			var my_pos = global_transform.origin
			
			# Flatten Y so rotation is only horizontal
			target_pos.y = my_pos.y

			#look_at(target_pos, Vector3.UP)
		shoot()

## Gets the closest enemy to the player
func get_closest_enemy() -> Node:
	var enemies = get_tree().get_nodes_in_group("enemies") # Get all available enemies in the world
	var closest_enemy = null 
	var closest_distance = INF
	
	
	if enemies != null:
		for enemy in enemies:
			if not enemy or not enemy.is_inside_tree():
				continue
			
			# Capture the distance from the player to the enemy
			var distance = global_transform.origin.distance_to(enemy.global_transform.origin)
			
			# 
			if distance < closest_distance:
				closest_distance = distance
				closest_enemy = enemy
	
	return closest_enemy


## Shoots projectile in the direction the player is facing
func shoot():
	var bullet = PLAYER_PROJECTILE.instantiate()
	bullet.global_transform = marker.global_transform
	
	get_tree().current_scene.add_child(bullet)


func rotate_toward_mouse():
	var mouse_pos = get_viewport().get_mouse_position()
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * 1000

	var space_state = get_world_3d().direct_space_state

	var query = PhysicsRayQueryParameters3D.new()
	query.from = from
	query.to = to
	query.exclude = [self]

	var result = space_state.intersect_ray(query)
	
	if result:
		var target = result.position
		target.y = global_transform.origin.y  # keep flat
		look_at(target, Vector3.UP)
