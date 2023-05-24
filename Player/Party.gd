extends Node

export var member1: Resource
export var member2: Resource
export var member3: Resource
export var member4: Resource


func getMemberByName(name):
	var members = [member1, member2, member3, member4]
	for member in members:
		if member.getName() == name:
			return member
