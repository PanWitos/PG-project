extends Control

func select(option):
	get_node(String(option)).color = Color(0.1, 0.1, 0.1, 1)
	
func unselect(option):
	get_node(String(option)).color = Color(0.3, 0.3, 0.3, 1)
