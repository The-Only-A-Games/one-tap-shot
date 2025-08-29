extends CharacterBody3D


## Player Stats

@onready var marker = %Marker3D
const PLAYER_PROJECTILE = preload("res://Scenes/Projectiles/player_projectile.tscn")

func _physics_process(delta):
	
	if Input.is_action_just_pressed("shoot"):
		var enemy = get_closest_enemy()
		
		if enemy != null:
			var target_pos = enemy.global_transform.origin
			var my_pos = global_transform.origin
			
			# Flatten Y so rotation is only horizontal
			target_pos.y = my_pos.y

			look_at(target_pos, Vector3.UP)
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
