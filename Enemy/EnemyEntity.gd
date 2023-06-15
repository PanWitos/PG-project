extends Sprite

signal completed

onready var selector = $Selector

var active: bool = false

export var statistics: Resource

func play_turn():
	active = true
	selected()
	yield(get_tree().create_timer(1), "timeout")
	performAction()
	print(statistics.enemyName)
	return self
	
func performAction():
	if active:
		var player = Party.getRandAliveMember()
		print(player)
		player.getHit(2)
		active = false
		unselected()
		emit_signal("completed")
			
func selected():
	selector.visible = true
	
func unselected():
	selector.visible = false
	
func getHit(damage):
	statistics.currentHealth -= damage
	if statistics.currentHealth <= 0:
		queue_free()

func getInitiative():
	return statistics.getInitiative()
	
