extends Sprite

signal completed

var active: bool = false

export var statistics: Resource

func play_turn():
	print(statistics.characterName)
	active = true
	return self
	
func _unhandled_input(event):
	if active:
		if event.is_action_pressed("complete"):
			active = false
			SignalBus.emit_signal("select")
			yield(get_parent().get_parent(), "actionExecuted")
			emit_signal("completed")
			
func getDamage():
	return statistics.getDamage()
