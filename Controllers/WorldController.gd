extends Node

onready var player = $Player

func pauseGame():
	player.paused = true

func unpaudeGame():
	player.paused = false

func isPaused():
	return player.paused
