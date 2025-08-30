extends CharacterBody3D


##Enemy Attributes
const SPEED = 1.5
var can_shoot = true


## Enemy Tools
@onready var nav_agent = $NavigationAgent3D
var canvas_layer
var player
var camera
const EXPLOSION = preload("res://Scenes/explosion.tscn")
const ENEMY_PROJECTILE = preload("res://Scenes/Projectiles/enemy_projectile.tscn")
@onready var player_detection = $PlayerDetection
@onready var timer = $Timer
@onready var marker = %Marker
@onready var animation_player = $AnimationPlayer
@onready var blaster_sound = $BlasterSound


func _ready():
	player = get_tree().get_first_node_in_group("player")
	canvas_layer = get_tree().get_first_node_in_group("canvas_layer")
	camera = get_tree().get_first_node_in_group("camera")
	animation_player.play("Hover")


func _physics_process(delta):
	if (player != null): # Move to player if player was found
		nav_agent.set_target_position(player.global_position)
		var next_nav_point = nav_agent.get_next_path_position()
		var lookDirection = Vector3(player.global_position.x, 0, player.global_position.z)
		look_at(lookDirection, Vector3.UP)
		
		velocity = (next_nav_point - global_position).normalized() * SPEED
		move_and_slide()
	
	if canvas_layer != null:
		if (canvas_layer.get_health() <= 0):
			queue_free()
			explode_enemy()
	
	var collider = player_detection.get_collider()
	
	if collider != null and collider.is_in_group("player"):
		if can_shoot:
			shoot()
			can_shoot = false
			timer.stop()
			timer.start()


## FOR PLAYER!!!
# player calls kill() to kill the player
func kill():
	explode_enemy()
	camera.apply_shake()
	queue_free()


func explode_enemy():
	var explosion = EXPLOSION.instantiate()
	explosion.global_transform = marker.global_transform
	get_tree().current_scene.add_child(explosion)
	explosion.explode()

func shoot():
	blaster_sound.play()
	var bullet = ENEMY_PROJECTILE.instantiate()
	add_child(bullet)
	bullet.global_transform = marker.global_transform


func _on_timer_timeout():
	can_shoot = true
