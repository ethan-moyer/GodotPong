extends Node2D


export var max_score = 9
var score_p1 = 0
var score_p2 = 0
var label_score_p1
var label_score_p2
var label_winner
var ball

func _ready():
	label_score_p1 = $ScoreP1
	label_score_p2 = $ScoreP2
	label_winner = $WinnerLabel
	ball = $Ball
	
	ball.set_process(false)
	new_round()

func new_round():
	if score_p1 >= max_score:
		label_winner.text = "P1 Wins"
		label_winner.visible = true
	elif score_p2 >= max_score:
		label_winner.text = "P2 Wins"
		label_winner.visible = true
	else:
		yield(get_tree().create_timer(1), "timeout")
		ball.set_process(true)
		ball.reset_ball()

func on_off_right():
	score_p1 += 1
	label_score_p1.text = str(score_p1)
	ball.set_process(false)
	new_round()

func on_off_left():
	score_p2 += 1
	label_score_p2.text = str(score_p2)
	ball.set_process(false)
	new_round()
