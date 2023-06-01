extends StaticBody2D

export var quest: Resource

export var dialogText: String

var startedQuest = false
var finishedQuest = false

func getText():
	return dialogText
		
func interact():
	if quest != null:
		if !startedQuest and !finishedQuest:
			dialogText = quest.beginText
			add_to_group("active_quest")
			startedQuest = true
			
		if startedQuest and !finishedQuest:
			dialogText = quest.activeText
			
		if startedQuest and finishedQuest:
			remove_from_group("active_quest")
			dialogText = quest.finishedText
	getText()
