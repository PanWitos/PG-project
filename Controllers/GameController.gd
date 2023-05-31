extends Node

onready var uiController = $UIController
onready var worldController = $UIController/WorldViewport/Viewport/WorldController
onready var bufferTimer = $BufferTimer

var dialog: bool = false
var buffer: bool = false

func _ready():
	SignalBus.connect("dialog_start", self, "startDialog")

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
		
func _on_BufferTimer_timeout():
	buffer = false
