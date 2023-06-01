extends Node

onready var uiController = $UIController
onready var worldController = $UIController/WorldViewport/Viewport/WorldController
onready var bufferTimer = $BufferTimer

var dialog: bool = false
var buffer: bool = false
var inventory: bool = false

func _ready():
	SignalBus.connect("dialog_start", self, "startDialog")
	
func openInventory():
	buffer = true
	worldController.pauseGame()
	uiController.openInventory()
	bufferTimer.start()
	inventory = true

func closeInventory():
	uiController.closeInventory()
	worldController.unpaudeGame()
	inventory = false
	
func startDialog():
	buffer = true
	worldController.pauseGame()
	uiController.startDialog()
	bufferTimer.start()
	dialog = true
	
func endDialog():
	uiController.endDialog()
	worldController.unpaudeGame()
	dialog = false

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if event.is_action_pressed("ui_select") and dialog and !buffer:
		endDialog()
	if event.is_action_pressed("ui_toggle_inventory"):
		if inventory == true and !buffer:
			closeInventory()
		elif inventory == false:
			openInventory()
		
func _on_BufferTimer_timeout():
	buffer = false
