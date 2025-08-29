extends CanvasLayer

var score = 0


func player_damage(n):
	%Health.value -= n


func update_score(n):
	score += n
	%Label.text = "Kills: " + str(score)
