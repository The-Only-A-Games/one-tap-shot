extends CharacterBody3D


##Enemy Attributes
const SPEED = 2


## Enemy Tools
@onready var nav_agent = %NavigationAgent
@onready var area_3d = $Area3D
var canvas_layer
var player
var camera
@onready var quek = $Quek
const EXPLOSION = preload("res://Scenes/explosion.tscn")
@onready var marker = $Marker


func _ready():
	player = get_tree().get_first_node_in_group("player")
	canvas_layer = get_tree().get_first_node_in_group("canvas_layer")
	camera = get_tree().get_first_node_in_group("camera")


func _physics_process(delta):
	if (player != null): # Move to player if player was found
		nav_agent.set_target_position(player.global_position)
		var next_nav_point = nav_agent.get_next_path_position()
		var lookDirection = Vector3(player.global_position.x, 0, player.global_position.z)
		look_at(lookDirection, Vector3.UP)
		
		velocity = (next_nav_point - global_position).normalized() * SPEED
		
		
		## Only move while the player is still alive
		if canvas_layer.get_health() > 0:
			move_and_slide()
		
		if (canvas_layer.get_health() <= 0):
			queue_free()
			explode_enemy()


## FOR PLAYER!!!
# player calls kill() to kill the player
func kill():
	explode_enemy()
	camera.apply_shake()
	queue_free()


func explode_enemy():
	quek.queue_free()
	var explosion = EXPLOSION.instantiate()
	explosion.global_transform = marker.global_transform
	get_tree().current_scene.add_child(explosion)
	explosion.explode()


## Damage player if close enough
func _on_area_3d_body_entered(body):
	if body.is_in_group("player"):
		canvas_layer.player_damage(10)
		explode_enemy()
		camera.apply_shake()
		queue_free()
