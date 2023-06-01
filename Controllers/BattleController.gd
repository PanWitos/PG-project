extends Node

onready var enemyContainer = get_node("Camera2D")

func startBattle():
	var enemyScene = load('res://Enemy/EnemyEntity.tscn')
	for i in 3:
		var enemyInstance = enemyScene.instance()
		var texture = load("res://Assets/Textures/test_rat.png")
		enemyInstance.texture = texture
		var res = load('res://Enemy/Rat.tres')
		enemyInstance.statistics = res
		enemyContainer.get_node('Pos'+str(i)).add_child(enemyInstance)
