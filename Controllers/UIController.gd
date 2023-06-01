extends Control

onready var dialogBox = $DialogBox
onready var dialogText = $DialogBox/DialogText
	
func startDialog(text):
	dialogText.bbcode_text = "[center]" + text + "[center]"
	dialogBox.visible = true
	
func endDialog():
	dialogBox.visible = false
	dialogText.bbcode_text = ""
