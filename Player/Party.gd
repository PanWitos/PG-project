extends Node

var members

func _ready():
	var member1 = load("res://Player/Aragorn.tres")
	var member2 = load("res://Player/Boromir.tres")
	var member3 = load("res://Player/Member3.tres")
	var member4 = load("res://Player/Member4.tres")
	members = [member1, member2, member3, member4]
	
	for member in members:
		member.currentHealth = member.maxHealth
	
func getMemberByName(name):
	for member in members:
		if member.getName() == name:
			return member
			
func getRandAliveMember():
	var aliveMembers = []
	for member in members:
		if member.dead == false:
			aliveMembers.append(member)
	
	var size = aliveMembers.size()
	var index = int(rand_range(0, aliveMembers.size()))
	
	return aliveMembers[int(rand_range(0, aliveMembers.size()))]
