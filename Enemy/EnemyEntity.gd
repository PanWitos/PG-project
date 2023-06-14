extends Sprite

signal completed

onready var selector = $Selector

var active: bool = false

export var statistics: Resource

func play_turn():
	active = true
	print(statistics.enemyName)
	return self
	
func _unhandled_input(event):
	if active:
		if event.is_action_pressed("complete"):
			active = false
			emit_signal("completed")
			
			
func selected():
	selector.visible = true
	
func unselected():
	selector.visible = false
	
func getHit(damage):
	statistics.currentHealth -= damage
	if statistics.currentHealth <= 0:
		queue_free()
	
