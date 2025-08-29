extends CanvasLayer

var score = 0
@onready var button = %Button
@onready var game_over_menu = $GameOverMenu


## Decreses the player health bar
func player_damage(n):
	%Health.value -= n


## Gets the player healh value
func get_health():
	return %Health.value


## Update the kill score
func update_score(n):
	score += n
	%Label.text = "Kills: " + str(score)


## Reloads game when button is pressed
func _on_button_pressed():
	get_tree().reload_current_scene()


## Displays the game over screen
func game_over_screen():
	game_over_menu.visible = true
	


func _on_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
