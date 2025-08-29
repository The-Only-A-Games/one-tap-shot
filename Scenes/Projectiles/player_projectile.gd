extends Area3D


## Bullet Attributes
const SPEED = 20
const DISTANCE_LIMIT = 2.0
const TRAVEL_RATE = 2
var travelled_distance = 00


func _physics_process(delta):
	position += -transform.basis.z * SPEED * delta
	
	travelled_distance += TRAVEL_RATE * delta
	
	if travelled_distance >= DISTANCE_LIMIT:
		queue_free()



func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.kill()
