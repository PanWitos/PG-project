extends Control

onready var dialogBox = $DialogBox
	
func startDialog():
	dialogBox.visible = true
	
func endDialog():
	dialogBox.visible = false
