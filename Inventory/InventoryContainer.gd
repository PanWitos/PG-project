extends ColorRect
onready var inventoryContainer = $InventoryContainer
onready var menuContainer = $ItemMenuContainer
onready var playerContainer = $PlayerContainer

var invSlots = []
var menuSlots = []
var playerSlots = []

var invFlag = true
var menuFlag = false
var playerFlag = false

var invRows = 7
var invCols = 4
var menuRows = 2
var menuCols = 2
var playerRows = 2
var playerCols = 2

var selectedMenuCol = null
var selectedMenuRow = null
var activeMenuCol = null
var activeMenuRow = null

var activeInvCol = null
var activeInvRow = null
var selectedInvCol = null
var selectedInvRow = null

var activePlayerCol = null
var activePlayerRow = null

var actionEquip = false


func _input(event):
	if visible:
		if event.is_action_pressed("ui_up"):
			#selectNewSlot(activeInvRow - 1, activeInvCol)
			selectNewSlot(-1, 0)
		if event.is_action_pressed("ui_down"):
			#selectNewSlot(activeInvRow + 1, activeInvCol)
			selectNewSlot(1, 0)
		if event.is_action_pressed("ui_left"):
			#selectNewSlot(activeInvRow, activeInvCol - 1)
			selectNewSlot(0, -1)
		if event.is_action_pressed("ui_right"):
			#selectNewSlot(activeInvRow, activeInvCol + 1)
			selectNewSlot(0, 1)
		
		if event.is_action_pressed("ui_select"):
			if invFlag and !invSlots[activeInvRow][activeInvCol].isEmpty():
				selectedInvCol = activeInvCol
				selectedInvRow = activeInvRow
				invFlag = false
				menuFlag = true
				selectMenuSlot(0, 0)
			elif menuFlag:
				if activeMenuRow == 1 and activeMenuCol == 0: # destroy
					destroyItem(selectedInvRow, selectedInvCol)
					unselectMenuSlot(activeMenuRow, activeMenuCol)
					invFlag = true
					menuFlag = false
				# equip or use
				#equip item if slot empty
				playerFlag = true
				actionEquip = true
				selectPlayerSlot(0, 0)
				menuFlag = false
			elif playerFlag:
				if activeMenuRow == 0 and activeMenuCol == 0:
					# select player to use item on
					var item = invSlots[selectedInvRow][selectedInvCol].getItem()
					if item.getItemType() == 'Usable':
						playerSlots[activePlayerRow][activePlayerCol].useItem(item)
						destroyItem(selectedInvRow, selectedInvCol)
						unselectMenuSlot(activeMenuRow, activeMenuCol)
						unselectPlayerSlot(activePlayerRow, activePlayerCol)
						playerFlag = false
						invFlag = true
					else:
						unselectMenuSlot(activeMenuRow, activeMenuCol)
						unselectPlayerSlot(activePlayerRow, activePlayerCol)
						playerFlag = false
						invFlag = true
				if activeMenuRow == 0 and activeMenuCol == 1:
					# select player to equip
					var item = invSlots[selectedInvRow][selectedInvCol].getItem()
					playerSlots[activePlayerRow][activePlayerCol].equipItem(item)
					unselectMenuSlot(activeMenuRow, activeMenuCol)
					unselectPlayerSlot(activePlayerRow, activePlayerCol)
					playerFlag = false
					invFlag = true
				
				

func destroyItem(row, col):
	invSlots[activeInvRow][activeInvCol].destroyItem()

func selectNewSlot(xPos, yPos):
	if invFlag:
		var row = (activeInvRow + xPos) % invRows
		var col = (activeInvCol + yPos) % invCols
		invSlots[activeInvRow][activeInvCol].unselectSlot()
		selectInvSlot(row, col)
	if menuFlag:
		var row = (activeMenuRow + xPos) % menuRows
		var col = (activeMenuCol + yPos) % menuCols
		menuSlots[activeMenuRow][activeMenuCol].unselectSlot()
		selectMenuSlot(row, col)
	if playerFlag:
		var row = (activePlayerRow + xPos) % playerRows
		var col = (activePlayerCol + yPos) % playerCols
		playerSlots[activePlayerRow][activePlayerCol].unselectSlot()
		selectPlayerSlot(row, col)


func selectInvSlot(row, col):
	invSlots[row][col].selectSlot()
	activeInvRow = row
	activeInvCol = col

func selectMenuSlot(row, col):
	menuSlots[row][col].selectSlot()
	activeMenuRow = row
	activeMenuCol = col

func selectPlayerSlot(row, col):
	playerSlots[row][col].selectSlot()
	activePlayerRow = row
	activePlayerCol = col
	
func unselectMenuSlot(row, col):
	menuSlots[row][col].unselectSlot()

func unselectPlayerSlot(row, col):
	playerSlots[row][col].unselectSlot()
	
func _ready():
	visible = false
	# Loading inventory slots to table 
	for row in range(invRows):
		var rowSlots = []
		for col in range(invCols):
			var slotIndex = row * invCols + col
			var slot = inventoryContainer.get_child(slotIndex)
			rowSlots.append(slot)
		invSlots.append(rowSlots)
	# Loading menu slots to table 
	for row in range(menuRows):
		var rowSlots = []
		for col in range(menuCols):
			var slotIndex = row * menuCols + col
			var slot = menuContainer.get_child(slotIndex)
			rowSlots.append(slot)
		menuSlots.append(rowSlots)
	
	for row in range(playerRows):
		var rowSlots = []
		for col in range(playerCols):
			var slotIndex = row * playerCols + col
			var slot = playerContainer.get_child(slotIndex)
			rowSlots.append(slot)
		playerSlots.append(rowSlots)
	
	
	
	selectInvSlot(1, 1)
	activeInvRow = 1
	activeInvCol = 1
	
	#dummy loading of one item
	var item = load("res://Inventory/items/health_potion.tres")
	invSlots[2][2].putItem(item)
	item = load("res://Inventory/items/pistol.tres")
	invSlots[2][3].putItem(item)
	item = load("res://Inventory/items/armor.tres")
	invSlots[3][2].putItem(item)


#func selectNewSlot1(row, col):
	
	# if inventory:
	#	var localRows = invRows
	# 	var localCols = invCols
	# elif menu:
	#	var localRows = menuRows
	# 	var localCols = menuCols
	
	# 
#	if row < 0:
#		row = invRows-1
#	if row > invRows-1:
#		row = 0
#	if col < 0:
#		col = invCols-1
#	if col > invCols-1:
#		col = 0
#	invSlots[activeInvRow][activeInvCol].unselectSlot()
#	selectInvSlot(row, col)



