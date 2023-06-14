extends Node

onready var uiController = $UIController
onready var worldController = $UIController/WorldViewport/Viewport/WorldController
onready var bufferTimer = $BufferTimer
onready var battleViewport = $UIController/BattleViewport
onready var battleController = $UIController/BattleViewport/Viewport/BattleController

var dialog: bool = false
var buffer: bool = false
var inventory: bool = false
var battle: bool = false

func _ready():
	SignalBus.connect("dialog_start", self, "startDialog")
	SignalBus.connect("battle_start", self, "startBattle")
	SignalBus.connect("battle_end", self, "endBattle")
	
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

func startBattle():
	if battle != true:
		battle = true
		worldController.pauseGame()
		battleViewport.visible = true
		battleController.startBattle()
		
func endBattle():
	if battle:
		battleController.endBattle()
		battle = false
		worldController.unpaudeGame()
		battleViewport.visible = false

func endDialog():
	uiController.endDialog()
	worldController.unpaudeGame()
	dialog = false

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if event.is_action_pressed("ui_select") and dialog and !buffer:
		endDialog()
	if event.is_action_pressed("ui_toggle_inventory") and !battle:
		if inventory == true and !buffer:
			closeInventory()
		elif inventory == false:
			openInventory()
		
func _on_BufferTimer_timeout():
	buffer = false
