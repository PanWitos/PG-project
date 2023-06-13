extends Resource

class_name questTemplate

export var name: String
export var id: int

export(String, "Talk", "Kill", "Bring") var questType

export var target: int

export var beginText: String
export var activeText: String
export var finishedText: String

func getId():
	return id

func getTarget():
	return target


