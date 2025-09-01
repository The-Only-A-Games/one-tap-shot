extends Area3D

@onready var pick_up_sound = $PickUpSound
var canvas_layer
@onready var pick_up = $PickUp


func _ready():
	canvas_layer = get_tree().get_first_node_in_group("canvas_layer")
	var pos = get_random_position_in_box(Vector3(0,0,0), Vector3(10,0,10))
	global_transform.origin = pos

func _on_body_entered(body):
	if body.is_in_group("player"):
		pick_up_sound.play()
		canvas_layer.reset_power_up()
		pick_up.visible = false
		await get_tree().create_timer(1.83).timeout
		queue_free()


func get_random_position_in_box(center: Vector3, size: Vector3) -> Vector3:
	var x = randf_range(center.x - size.x/2, center.x + size.x/2)
	var z = randf_range(center.z - size.z/2, center.z + size.z/2)
	return Vector3(x, 0.0, z)  # force Y to always be 0
