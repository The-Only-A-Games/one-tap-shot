extends CanvasLayer

var score = 0
@onready var button = %Button
@onready var game_over_menu = $GameOverMenu
@onready var total_kills = $GameOverMenu/TotalKills
@onready var pause_total = $PauseMenu/PauseTotal
@onready var pause_menu = $PauseMenu
@onready var pause = $Control/Pause
@onready var power_up = $Control/PowerUp
@onready var instructions = $Control/Instructions

const INSTRUCTION_TIME_LIMIT = 60
var count_sec = 0

func _physics_process(delta):
	total_kills.text = "Total Kills: " + str(score)
	pause_total.text = "Total Kills: " + str(score)
	
	## Whenever a power up has been picked up decrease it
	power_up.value -= 15 * delta
	
	count_sec *= delta
	
	if count_sec >= INSTRUCTION_TIME_LIMIT:
		instructions.queue_free()

## Decreses the player health bar
func player_damage(n):
	%Health.value -= n


## Gets the player's healh value
func get_health():
	return %Health.value


## Update the kill score
func update_score(n):
	score += n
	%Label.text = "Kills: " + str(score)


## Get the player's score
func get_score():
	return score

## Reloads game when button is pressed
func _on_button_pressed():
	get_tree().reload_current_scene()


## Displays the game over screen
func game_over_screen():
	pause.visible = false
	game_over_menu.visible = true
	


func _on_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")


func _on_pause_pressed():
	pause.visible = false
	pause_menu.visible = true
	get_tree().paused = true


func _on_replay_pressed():
	get_tree().reload_current_scene()


func _on_resume_pressed():
	pause.visible = true
	pause_menu.visible = false
	get_tree().paused = false


func get_power_up():
	return power_up.value


func reset_power_up():
	power_up.value = 100
