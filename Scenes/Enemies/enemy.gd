extends CharacterBody3D


##Enemy Attributes
const SPEED = 5

## Enemy Tools
@onready var nav_agent = %NavigationAgent
var player


func _ready():
	player = get_tree().get_first_node_in_group("player")


func _physics_process(delta):
	if (player != null):
		nav_agent.set_target_position(player.global_position)
		var next_nav_point = nav_agent.get_next_path_position()
		var lookDirection = Vector3(player.global_position.x, 0, player.global_position.z)
		look_at(lookDirection)
		
		velocity = (next_nav_point - global_position).normalized() * SPEED
		move_and_slide()

func kill():
	queue_free()
