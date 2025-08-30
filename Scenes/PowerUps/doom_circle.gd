extends Area3D


var canvas_layer

func _ready():
	canvas_layer = get_tree().get_first_node_in_group("canvas_layer")


func _physics_process(delta):
	if canvas_layer.get_power_up() <= 0:
		queue_free()

func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.kill()
		canvas_layer.update_score(1)
