extends StaticBody2D

export var id: int
export var questId: int = 0
var dialogText: String
export var firstDialog: String
export var secondDialog: String

func getText():
	return dialogText
		
func interact():
	dialogText = firstDialog
	checkQuest()
	if questId != 0:
		if Quests.getQuest(questId) == null:
			var quest = load("res://Quests/" + String(questId) + ".tres")
			Quests.addQuest(quest)
			dialogText = quest.beginText
		else:
			dialogText = Quests.getQuest(questId).activeText
		
		if Quests.getFinishedQuest(questId) != null:
			dialogText = Quests.getFinishedQuest(questId).finishedText
			
	return getText()

func checkQuest():
	var check = Quests.getTarget(id)
	if check != null:
		Quests.finishQuest(check.getId())
		dialogText = secondDialog
