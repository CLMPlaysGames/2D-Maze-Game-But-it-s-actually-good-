extends Node

var currentLevel
var score

func _ready():
	currentLevel = 1
	score = 0
	
func nextLevel():
	get_node("Level" + str(currentLevel)).queue_free()
	
	currentLevel += 1
	
	var newLevelPath = load("res://Level" + str(currentLevel) + ".tscn")
	
	if newLevelPath:
		var newLevel = newLevelPath.instance()
		call_deferred("add_child", newLevel)
	else:
		get_node("UI/GameWin").visible = true