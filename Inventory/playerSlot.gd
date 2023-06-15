extends Panel

var default_tex = preload("res://Assets/UI/player_slot_default_background.png")
var selected_tex = preload("res://Assets/UI/player_slot_selected_background.png")
var default_style: StyleBoxTexture
var selected_style: StyleBoxTexture

var is_active = false
export var armorResource : Resource = null
export var weaponResource : Resource = null
onready var armorSlot = $Armor
onready var weaponSlot = $Weapon
onready var armorTextureRect = $Armor/TextureRect
onready var weaponTextureRect = $Weapon/TextureRect

export var playerId:int = 0


func _ready():
	default_style = StyleBoxTexture.new()
	selected_style = StyleBoxTexture.new()
	default_style.texture = default_tex
	selected_style.texture = selected_tex
	refresh_style()
	
func equipItem(itemResc):
	print (itemResc.get_instance_id())
	var itemType = itemResc.getItemType()
	
	if itemType == "Armor" or itemType == "Weapon":
		if !itemResc.isEquiped(): # item isn't equiped
			if itemType == "Armor" and armorResource == null:
				armorResource = itemResc
				armorTextureRect.texture = itemResc.getTexture()
				itemResc.setEquiped()
				Party.members[playerId].equipArmor(itemResc)
			elif itemType == "Weapon" and weaponResource == null:
				weaponResource = itemResc
				weaponTextureRect.texture = itemResc.getTexture()
				itemResc.setEquiped()
				Party.members[playerId].equipWeapon(itemResc)
		else:
			if itemType == "Armor" and armorResource!= null:
				if armorResource.get_instance_id() == itemResc.get_instance_id():
					armorResource = null
					armorTextureRect.texture = null
					itemResc.setUnequiped()
			if itemType == "Weapon" and weaponResource!= null:
				if weaponResource.get_instance_id() == itemResc.get_instance_id():
					weaponResource = null
					weaponTextureRect.texture = null
					itemResc.setUnequiped()

func useItem(itemResc):	
	var itemType = itemResc.getItemType()
	if itemType == "Usable":
		#use item on player
		pass

func destroyItem():
	pass

func isEmpty():
	if armorResource:
		return false
	return true
	
func refresh_style():
	if is_active:
		set('custom_styles/panel', selected_style)
	else:
		set('custom_styles/panel', default_style)

func selectSlot():
	is_active = true
	refresh_style()
	
func unselectSlot():
	is_active = false
	refresh_style()
	

