extends Area2D


export var speed = 150
var ball
var tracking = true


func _ready():
	ball = get_node("../Ball")


func _process(delta):
	if tracking:
		position.y = move_toward(position.y, ball.ai_position.y, speed * delta)
	else:
		position.y = move_toward(position.y, ball.position.y, speed * delta)
	position.y = clamp(position.y, 4+20, 252-20)


func on_tracking_start():
	tracking = true

func on_tracking_stop():
	tracking = false
