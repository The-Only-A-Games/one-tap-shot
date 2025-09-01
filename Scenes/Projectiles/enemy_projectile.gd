extends Area3D

## Bullet Attributes
const SPEED = 15
const DISTANCE_LIMIT = 4.0
const TRAVEL_RATE = 2
var travelled_distance = 00
var canvas_layer
var camera
var enemy_shot = false
@onready var gpu_particles_3d = $GPUParticles3D
@onready var bullet_mesh = $BulletMesh
@onready var hit_sound = $HitSound
@onready var enemy_projectile = $"."
@onready var collision_shape_3d = $CollisionShape3D


func _ready():
	canvas_layer = get_tree().get_first_node_in_group("canvas_layer")
	camera = get_tree().get_first_node_in_group("camera")


func _physics_process(delta):
	if not enemy_shot:
		## Move projectile in the direction its facing
		position += -transform.basis.z * SPEED * delta
	
	
	travelled_distance += TRAVEL_RATE * delta
	# Destroy bullet if it reaches it travel distance limit
	if travelled_distance >= DISTANCE_LIMIT:
		queue_free()


## When it collides with the enemy : HURT PLAYER
func _on_body_entered(body):
	if body.is_in_group("player"):
		canvas_layer.player_damage(5)
		bullet_mesh.visible = false;
		gpu_particles_3d.emitting = true
		camera.apply_shake()
		enemy_shot = true
		hit_sound.play()
		collision_shape_3d.visible = false
		await get_tree().create_timer(0.5).timeout
		queue_free()
