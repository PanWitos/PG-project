extends Resource

class_name PartyMember

export var characterName: String

export var maxHealth: int setget setMaxHealth, getMaxHealth
export var currentHealth: int setget setCurrentHealth, getCurrentHealth

export var maxMana: int = 0 setget setMaxMana, getMaxMana
var currentMana: int = 0 setget setCurrentMana, getCurrentMana

export var statistics = {
	"Strength" : 0,
	"Accuracy" : 0,
	"Agility" : 0,
	"Wisdom": 0,
	"Vitality": 0
}

export var experience = 0
export var level = 0
export var experienceRates = [250, 500, 1000, 2000]

export var armor : Resource = null
export var weapon : Resource = null

export var dead: bool = false


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
	return characterName

func getDamage():
	var damage = statistics["Strength"] * 10
	return damage
	
func getHit(damage):
	currentHealth -= damage
	print(currentHealth)

func checkHealth():
	if currentHealth <= 0:
		dead = true
		
func gainExperience(amount):
	experience += amount
	if experience > experienceRates[level]:
		levelUp()

func levelUp():
	level += 1
	for statistic in statistics:
		statistics[statistic] += 1


func getInitiative():
	var initiative = statistics["Agility"] * 10 + randi()%7 + 1
	return statistics["Agility"]
