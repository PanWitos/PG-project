extends Control

onready var dialogBox = $DialogBox
onready var dialogText = $DialogBox/DialogText
onready var inventoryContainer = $InventoryContainer

	
func startDialog(text):
	dialogText.bbcode_text = "[center]" + text + "[center]"
	dialogBox.visible = true
	
func endDialog():
	dialogBox.visible = false

	dialogText.bbcode_text = ""

func openInventory():
	inventoryContainer.visible = true
	
func closeInventory():
	inventoryContainer.visible = false
