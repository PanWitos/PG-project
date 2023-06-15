extends Sprite

signal completed

var active: bool = false

var memberId = 0

onready var selector = $Selector

func play_turn():
	print(Party.members[memberId].characterName)
	active = true
	selected()
	return self
	
func _unhandled_input(event):
	if active:
		if event.is_action_pressed("complete"):
			active = false
			SignalBus.emit_signal("select")
			yield(get_parent().get_parent(), "actionExecuted")
			unselected()
			emit_signal("completed")
			
func getDamage():
	return Party.members[memberId].getDamage()
	
func checkHealth():
	Party.members[memberId].checkHealth()
	if Party.members[memberId].dead == true:
		queue_free()
	
func getInitiative():
	return Party.members[memberId].getInitiative()
	
func selected():
	selector.visible = true
	
func unselected():
	selector.visible = false
