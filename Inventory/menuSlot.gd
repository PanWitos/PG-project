extends Panel

var default_tex = preload("res://Assets/UI/menu_slot_default_background.png")
var selected_tex = preload("res://Assets/UI/menu_slot_selected_background.png")

var default_style: StyleBoxTexture
var selected_style: StyleBoxTexture

var is_active = false

export(String, "Use", "Move", "Equip", "Drop") var menuAction

func _ready():
	default_style = StyleBoxTexture.new()
	selected_style = StyleBoxTexture.new()
	default_style.texture = default_tex
	selected_style.texture = selected_tex
	refresh_style()
	

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
