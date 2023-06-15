extends Node

signal targetSelected
signal actionExecuted

onready var turnQueue = get_node("TurnQueue")
onready var menu = get_node("Menu")

var heroPositions = [Vector2(-130, 80), Vector2(-65, 80), Vector2(0, 80), Vector2(65, 80), Vector2(130, 80)]
var enemyPositions = [Vector2(-100, 0), Vector2(0, -50), Vector2(100, 0)]

var active: bool = false
var targeting: bool = false
var enemies = []
var targetEnemy: int = 0
var selectedOption = 0
var options = ["Attack", "Defend", "Pass"]

func _ready():
	SignalBus.connect("select", self, "selectAction")

func selectAction():
	if options[selectedOption] == "Attack":
		targetAction()
		print("Attack")
	elif options[selectedOption] == "Defend":
		print("Defend")
		yield(get_tree().create_timer(0.2), "timeout")
		emit_signal("actionExecuted")
	elif options[selectedOption] == "Pass":
		print("Pass")
		yield(get_tree().create_timer(0.2), "timeout")
		emit_signal("actionExecuted")
	
		
func targetAction():
	targetEnemy = 0
	targeting = true
	enemies = get_tree().get_nodes_in_group("Enemy")
	enemies[targetEnemy].selected()
	yield(self, "targetSelected")

func startBattle():
	active = true
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
		heroInstance.memberId = i
		if Party.members[heroInstance.memberId].dead == false:
			heroInstance.position = heroPositions[i]
			turnQueue.add_child(heroInstance)
	
	turnQueue.initialize()

func endBattle():
	var children = turnQueue.get_children()
	for child in children:
		child.queue_free()
	active = false
	targeting = false
	targetEnemy = 0
	selectedOption = 0
	
func _input(event):
	if active and !targeting:
		if event.is_action_pressed("ui_up"):
			unselectOption(options[selectedOption])
			selectedOption = int((selectedOption - 1))%3
			selectOption(options[selectedOption])
		if event.is_action_pressed("ui_down"):
			unselectOption(options[selectedOption])
			selectedOption = int((selectedOption + 1))%3
			selectOption(options[selectedOption])
	if active and targeting:
		if event.is_action_pressed("ui_left"):
			unselectTarget()
			targetEnemy = int((targetEnemy - 1))%enemies.size()
			selectTarget()
		if event.is_action_pressed("ui_right"):
			unselectTarget()
			targetEnemy = int((targetEnemy + 1))%enemies.size()
			selectTarget()
		if event.is_action_pressed("complete"):
			performAttack()

func performAttack():
	var activeCharacter = turnQueue.active_character
	var enemy = enemies[targetEnemy]
	enemy.getHit(activeCharacter.getDamage())
	targeting = false
	emit_signal("actionExecuted")
	
func selectTarget():
	enemies[targetEnemy].selected()

func unselectTarget():
	enemies[targetEnemy].unselected()
	
func selectOption(option):
	menu.select(option)

func unselectOption(option):
	menu.unselect(option)

func _on_TurnQueue_resetMenu():
	selectedOption = 0
	unselectOption(options[1])
	unselectOption(options[2])
	selectOption(options[selectedOption])
