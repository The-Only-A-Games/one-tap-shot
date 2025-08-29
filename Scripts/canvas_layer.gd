extends CanvasLayer

var score = 0
@onready var button = %Button
@onready var game_over_menu = $GameOverMenu


func player_damage(n):
	%Health.value -= n

func get_health():
	return %Health.value

func update_score(n):
	score += n
	%Label.text = "Kills: " + str(score)


func _on_button_pressed():
	get_tree().reload_current_scene()

func game_over_screen():
	game_over_menu.visible = true
	
