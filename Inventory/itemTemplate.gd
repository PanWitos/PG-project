extends Resource

class_name itemTemplate

export var id: int
export var name: String
export var itemPower: int
export(String, "Armor", "Weapon", "Usable", "QuestItem") var itemType
export var equiped: bool

export var texture: Texture



func getId():
	return id
	
func getTexture():
	return texture

func getItemType():
	return itemType
	
func getName():
	return name

func isEquiped():
	return equiped
	
func setEquiped():
	equiped = true

func setUnequiped():
	equiped = false
	
func use():
	# check item type 
	pass

func delete():
	# not sure
	pass
