extends Node

var questList: Array
var finishedQuests: Array

func addQuest(quest: Resource):
	questList.append(quest)
	
func removeQuest(id):
	for quest in questList:
		if id == quest.getId():
			questList.erase(quest)
			
func getQuest(id):
	for quest in questList:
		if id == quest.getId():
			return quest
	return null
	
func getFinishedQuest(id):
	for quest in finishedQuests:
		if id == quest.getId():
			return quest
	return null
	
func finishQuest(id):
	for quest in questList:
		if id == quest.getId():
			questList.erase(quest)
			finishedQuests.append(quest)

func getTarget(id):
	for quest in questList:
		if id == quest.getTarget():
			return quest
		else:
			return null
