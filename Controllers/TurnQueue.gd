extends Node2D

class_name TurnQueue

var active_character

func initialize():
	var fighters = null #TODO
	fighters.sort_custom(self, 'sort_fighters')
	for fighter in fighters:
		fighter.raise()
	active_character = get_child(0)

func play_turn():
	yield(active_character.play_turn(), "completed")
	var new_index : int = (active_character.get_index() + 1) % get_child_count()
	active_character = get_child(new_index)

static func sort_fighters(a : Resource, b : Resource) -> bool:
	return a.getStatistics()["Agility"] > b.getStatistics()["Agility"]
