extends Area3D


## Bullet Attributes
const SPEED = 5

func _physics_process(delta):
	position += -transform.basis.z * SPEED * delta



func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.kill()
