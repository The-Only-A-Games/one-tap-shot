extends Node3D

@export var canvas_layer_path : NodePath
var canvas_layer

func _ready():
	canvas_layer = get_node(canvas_layer_path)
