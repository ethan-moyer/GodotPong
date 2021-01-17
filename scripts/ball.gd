extends Area2D
signal off_left
signal off_right
signal ai_start
signal ai_stop


export var speed = 200
const LEFT_SIDE = Vector2(128, 128)
const RIGHT_SIDE = Vector2(384, 128)
const ANGLE_MIN = -PI/3
const ANGLE_MAX = PI/3
var velocity = Vector2.ZERO
var ai_velocity = Vector2.ZERO
var ai_position = Vector2.ZERO


func _ready():
	connect("off_left", get_parent(), "on_off_left")
	connect("off_right", get_parent(), "on_off_right")
	randomize()
	reset_ball()


func reset_ball():
	var angle = rand_range(ANGLE_MIN, ANGLE_MAX)
	velocity = Vector2(cos(angle), sin(angle)) * speed
	if randf() > 0.5:
		position = LEFT_SIDE
	else:
		position = RIGHT_SIDE
		velocity.x *= -1
	ai_reset()


func ai_reset():
	ai_position = position
	ai_velocity = velocity * 2
	emit_signal("ai_start")


func _process(delta):
	position += velocity * delta
	ai_position += ai_velocity * delta
	position.y = clamp(position.y, 4 + 4, 252 - 4)
	ai_position.y = clamp(ai_position.y, 4 + 4, 252 - 4)
	if position.x > 512 + 4:
		emit_signal("off_right")
	if position.x < 0 - 4:
		emit_signal("off_left")
	if ai_position.x > 256 + 4:
		emit_signal("ai_stop")


func area_entered(area):
	if area.is_in_group("wall"):
		velocity.y *= -1
		ai_velocity.y *= -1
	if area.is_in_group("paddle"):
		var distance = position.y - area.position.y
		var angle = ANGLE_MAX * (distance / 20)
		var direction = 1 if velocity.x < 0 else -1
		velocity = Vector2(cos(angle), sin(angle)) * speed
		velocity.x *= direction
		if area.name == "Paddle1":
			ai_reset()
