extends Area2D


export var input_up = "ui_up"
export var input_down = "ui_down"
export var speed = 150


func _process(delta):
	var input_dir = Input.get_action_strength(input_down) - Input.get_action_strength(input_up)
	position.y += input_dir * speed * delta
	position.y = clamp(position.y, 4+20, 252-20)
