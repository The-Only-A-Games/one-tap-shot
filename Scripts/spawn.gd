extends Node3D


@onready var energy_scatter = $EnergyScatter
@onready var poof = $Poof

func spawn():
	energy_scatter.emitting = true
	poof.emitting = true
	await get_tree().create_timer(1.5).timeout
	queue_free()
