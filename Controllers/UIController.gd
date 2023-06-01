extends Control

onready var dialogBox = $DialogBox
onready var inventoryContainer = $InventoryContainer
	
func startDialog():
	dialogBox.visible = true
	
func endDialog():
	dialogBox.visible = false

func openInventory():
	inventoryContainer.visible = true
	
func closeInventory():
	inventoryContainer.visible = false
