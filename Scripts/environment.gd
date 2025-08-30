extends Node3D


@onready var world_environment = %WorldEnvironment
var blue_color := Color.hex(0x56c1d8)
var red_color := Color.hex(0xff0000)

func change_bg_color():
	world_environment.environment.background_color = red_color
	await get_tree().create_timer(0.2).timeout
	world_environment.environment.background_color = blue_color
