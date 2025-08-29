extends Area3D


## Bullet Attributes
const SPEED = 30
const DISTANCE_LIMIT = 2.0
const TRAVEL_RATE = 2
var travelled_distance = 00
var canvas_layer


func _ready():
	canvas_layer = get_tree().get_first_node_in_group("canvas_layer")


func _physics_process(delta):
	## Move projectile in the direction its facing
	position += -transform.basis.z * SPEED * delta
	
	
	travelled_distance += TRAVEL_RATE * delta
	# Destroy bullet if it reaches it travel distance limit
	if travelled_distance >= DISTANCE_LIMIT:
		queue_free()


## When it collides with the enemy : KILL ENEMY
func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.kill()
		canvas_layer.update_score(1)
		queue_free()
