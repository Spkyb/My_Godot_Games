extends Control

@onready var label_high_score : Label = $CenterContainer/VBoxContainer/HBoxContainer/HighScoreNumber
@onready var label_score : Label = $CenterContainer/VBoxContainer/ScoreNumber

func set_highscore(value : int) -> void:
	label_high_score.text = str(value)
func set_score(value : int) -> void:
	label_score.text = str(value)
