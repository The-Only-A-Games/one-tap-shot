extends Camera3D

@export var random_strength: float = 0.5   # how far the shake moves (in meters)
@export var shake_fade: float = 5.0        # how fast it fades

var rng = RandomNumberGenerator.new()
var shake_strength: float = 0.0
var original_transform: Transform3D

func _ready():
	original_transform = global_transform

func apply_shake():
	shake_strength = random_strength

func discard_shake():
	shake_strength = 0

func _physics_process(delta):
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0.0, shake_fade * delta)
		

		# random offset in X/Y
		var offset = Vector3(
			rng.randf_range(-shake_strength, shake_strength),
			rng.randf_range(-shake_strength, shake_strength),
			0
		)
		# apply offset to original transform
		global_transform.origin = original_transform.origin + offset
	else:
		# reset to original transform
		global_transform = original_transform
