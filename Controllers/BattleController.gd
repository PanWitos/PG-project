extends Node

onready var turnQueue = get_node("TurnQueue")
onready var heroes = [Party.member1, Party.member2]
var heroPositions = [Vector2(-130, 80), Vector2(-65, 80), Vector2(0, 80), Vector2(65, 80), Vector2(130, 80)]
var enemyPositions = [Vector2(-100, -50), Vector2(0, -50), Vector2(100, -50)]
func startBattle():
	var enemyScene = load('res://Enemy/EnemyEntity.tscn')
	var heroScene = load('res://Player/PartyMemberEntity.tscn')
	#var 
	for i in 3:
		var enemyInstance = enemyScene.instance()
		var texture = load("res://Assets/Textures/test_rat.png")
		enemyInstance.texture = texture
		var res = load('res://Enemy/Rat.tres')
		enemyInstance.statistics = res
		enemyInstance.position = enemyPositions[i]
		turnQueue.add_child(enemyInstance)
	
	for i in 4:
		var heroInstance = heroScene.instance()
		heroInstance.texture = load('res://Player/whatever.png')
		heroInstance.statistics = load('res://Player/Aragorn.tres')
		heroInstance.position = heroPositions[i]
		turnQueue.add_child(heroInstance)
	
	turnQueue.initialize()
