extends ColorRect

const SlotClass = preload("res://Controllers/Slot.gd")
onready var gridContainer = $GridContainer

var selectedSlotCol = null
var selectedSlotRow = null
var inventorySlots = []


func _ready():
	visible = false

	var numRows = 7
	var numCols = 4
	for row in range(numRows):
		var rowSlots = []
		for col in range(numCols):
			var slotIndex = row * numCols + col
			var slot = gridContainer.get_child(slotIndex)
			rowSlots.append(slot)
		inventorySlots.append(rowSlots)
	selectSlot(3, 2)


func _input(event):
	if visible:
		if event.is_action_pressed("ui_up"):
			selectNewSlot(selectedSlotRow - 1, selectedSlotCol)
		if event.is_action_pressed("ui_down"):
			selectNewSlot(selectedSlotRow + 1, selectedSlotCol)
		if event.is_action_pressed("ui_left"):
			selectNewSlot(selectedSlotRow, selectedSlotCol - 1)
		if event.is_action_pressed("ui_right"):
			selectNewSlot(selectedSlotRow, selectedSlotCol + 1)

func selectNewSlot(row, col):
	inventorySlots[selectedSlotRow][selectedSlotCol].unselectSlot()
	selectSlot(row, col)

func selectSlot(row, col):
	inventorySlots[row][col].selectSlot()
	selectedSlotRow = row
	selectedSlotCol = col
