extends Area2D

var speed
var move
var coin

func _ready():
	speed = 75
	move = Vector2()
	coin = 0
	
func _process(delta):
	move = Vector2()
	get_tree().get_root().get_node("Game/UI/Collectables").text = str(get_tree().get_root().get_node("Game").score)
	get_tree().get_root().get_node("Game/UI/Coins").text = str(coin)
	#get_tree().get_root().get_node("Game/UI/Extra Coins").text = str(Extra ,Coins)
	
	if (Input.is_action_pressed("ui_left") and !get_node("left").is_colliding()):
		move.x -= 1
	if (Input.is_action_pressed("ui_right") and !get_node("right").is_colliding()):
		move.x += 1
	if (Input.is_action_pressed("ui_down") and !get_node("down").is_colliding()):
		move.y += 1
	if (Input.is_action_pressed("ui_up") and !get_node("up").is_colliding()):
		move.y -= 1
		
	if (Input.is_action_pressed("ui_left") and get_node("left").is_colliding()):
		if (get_node("left").get_collider().is_in_group("obstacle") and coin > 0):
			get_node("left").get_collider().queue_free()
			coin -= 1
	if (Input.is_action_pressed("ui_right") and get_node("right").is_colliding()):
		if (get_node("right").get_collider().is_in_group("obstacle") and coin > 0):
			get_node("right").get_collider().queue_free()
			coin -= 1
	if (Input.is_action_pressed("ui_up") and get_node("up").is_colliding()):
		if (get_node("up").get_collider().is_in_group("obstacle") and coin > 0):
			get_node("up").get_collider().queue_free()
			coin -= 1
	if (Input.is_action_pressed("ui_down") and get_node("down").is_colliding()):
		if (get_node("down").get_collider().is_in_group("obstacle") and coin > 0):
			get_node("down").get_collider().queue_free()
			coin -= 1
		
	if (move.y > 0):
		get_node("AnimatedSprite").play("runningDown")
	if (move.y < 0):
		get_node("AnimatedSprite").play("runningUp")
		
	move.normalized()
	position += move * speed * delta

func _on_Player_area_entered(area):
	if (area.is_in_group("collect")):
		get_tree().get_root().get_node("Game").score += 1
		area.queue_free()
	if (area.is_in_group("hard mode")):
		get_node("Camera2D").zoom = Vector2(-0.15, -0.15)
		area.queue_free()
	if (area.is_in_group("enemy")):
		get_tree().get_root().get_node("Game/UI/GameOver").visible = true
		queue_free()
	if (area.is_in_group("coin")):
		coin += 1
		area.queue_free()
	if (area.is_in_group("goal")):
		get_tree().get_root().get_node("Game").nextLevel()