extends Area2D

var speed
var move

func _ready():
	speed = 50
	move = Vector2()
	
	randomize()
	var direction = rand_range(-1, 1)
	if direction > 0:
		move.x = 1
	else:
		move.y = 1
		
func _process(delta):
	if (move.y > 0 and get_node("down").is_colliding()):
		move.y *= -1
	elif (move.y < 0 and get_node("up").is_colliding()):
		move.y *= -1
	elif (move.x > 0 and get_node("right").is_colliding()):
		move.x *= -1
	elif (move.x < 0 and get_node("left").is_colliding()):
		move.x *= -1
	
	move.normalized()
	position += move * speed * delta