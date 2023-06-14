extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if randi() % 2 == 0:
		$TextureRect.texture = load("res://Assets/UI/health_potion.png")
	else:
		$TextureRect.texture = load("res://Assets/UI/empty_bottel.png")
