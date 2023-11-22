extends Node

var arena : Node = null
var score : int = 0
var high_score : int = 0

func add_score(value : int) -> void:
	score += value
	if arena != null:
		arena.get_node("HUD").set_score(score)
	if(score > high_score):
		high_score = score
		if arena != null:
			arena.get_node("HUD").set_highscore(score)
