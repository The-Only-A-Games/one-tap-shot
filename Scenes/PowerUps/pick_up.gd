extends Area3D


var canvas_layer
func _ready():
	canvas_layer = get_tree().get_first_node_in_group("canvas_layer")

func _on_body_entered(body):
	if body.is_in_group("player"):
		canvas_layer.reset_power_up()
		queue_free()
