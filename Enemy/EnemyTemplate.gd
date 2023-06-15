extends Resource

class_name Enemy

export var enemyName: String

export var texture: Texture

export var maxHealth: int setget setMaxHealth, getMaxHealth
var currentHealth: int setget setCurrentHealth, getCurrentHealth

export var maxMana: int = 0 setget setMaxMana, getMaxMana
var currentMana: int = 0 setget setCurrentMana, getCurrentMana

export var id: int

export var statistics = {
	"Strength" : 0,
	"Accuracy" : 0,
	"Agility" : 0,
	"Wisdom": 0,
	"Vitality": 0
}

enum actions {ATTACK, DEFEND, SKILL}

func setMaxMana(value):
	maxMana = value

func getMaxMana():
	return maxMana
	
func setCurrentMana(value):
	currentMana = value

func getCurrentMana():
	return currentMana
	
func setMaxHealth(value):
	maxHealth = value

func getMaxHealth():
	return maxHealth
	
func setCurrentHealth(value):
	currentHealth = value

func getCurrentHealth():
	return currentHealth
	
func setStatistics(statsDict):
	for stat in statsDict:
		if statsDict[stat] != null:
			statistics[stat] = statsDict[stat]

func getStatistics():
	return statistics
	
func getName():
	return enemyName

func getDamage():
	var damage = statistics["Strength"] * 10
	return damage

func getInitiative():
	var initiative = statistics["Agility"] * 10 + randi()%7 + 1
	return statistics["Agility"]
	
