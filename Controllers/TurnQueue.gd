extends Node2D

class_name TurnQueue

signal resetMenu

var active_character

func initialize():
	var fighters = get_children()
	fighters.sort_custom(self, 'sort_fighters')
	for fighter in fighters:
		fighter.raise()
	active_character = get_child(0)
	play_turn()

func play_turn():
	emit_signal("resetMenu")
	yield(active_character.play_turn(), "completed")
	# if(!active_character.is_in_group("Enemy")):
	var new_index : int = (active_character.get_index() + 1) % get_child_count()
	active_character = get_child(new_index)
	yield(get_tree().create_timer(0.2), "timeout")
	if checkBattle() == 0:
		SignalBus.emit_signal("battle_end")
		return
	play_turn()
	
func checkBattle():
	var enemies = get_tree().get_nodes_in_group("Enemy")
	if enemies.size() == 0:
		print("End")
		return 0
	else:
		return 1

static func sort_fighters(a : Sprite, b : Sprite) -> bool:
	return a.statistics.statistics["Agility"] > b.statistics.statistics["Agility"]
