extends Panel

var default_tex = preload("res://Assets/UI/item_slot_default_background.png")
var empty_tex = preload("res://Assets/UI/item_slot_empty_background.png")
var selected_tex = preload("res://Assets/UI/item_slot_selected_background.png")

var default_style: StyleBoxTexture
var empty_style: StyleBoxTexture
var selected_style: StyleBoxTexture

export var itemResource : Resource = null
var is_active = false

onready var textureRect = $TextureRect 


func putItem(itemResc):
	itemResource = itemResc
	textureRect.texture = itemResc.getTexture()

func destroyItem():
	itemResource = null
	textureRect.texture = null
	print('destroying')

func isEmpty():
	if itemResource:
		return false
	return true

func getItem():
	return itemResource
	
func _ready():
	default_style = StyleBoxTexture.new()
	empty_style = StyleBoxTexture.new()
	selected_style = StyleBoxTexture.new()
	
	default_style.texture = default_tex
	empty_style.texture = empty_tex
	selected_style.texture = selected_tex
	
	refresh_style()

func refresh_style():
	if is_active:
		set('custom_styles/panel', selected_style)
	elif itemResource == null:
		set('custom_styles/panel', empty_style)
	else:
		set('custom_styles/panel', default_style)
		

func selectSlot():
	is_active = true
	refresh_style()
	
func unselectSlot():
	is_active = false
	refresh_style()
