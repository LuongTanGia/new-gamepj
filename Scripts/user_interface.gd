extends Control

@onready var inventory: Control = $Inventory
@onready var item_slot: Array[Node] = $Inventory/GridContainer.get_children()

func _ready() -> void:
	if Engine.is_editor_hint():
		return

	if inventory != null:
		inventory.hide()

	update_inventory()

func _process(_delta: float) -> void:
	Global.inventory_changed.connect(update_inventory)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_inventory"):
		if inventory.is_visible():
			inventory.hide()
		else:
			inventory.show()

func update_inventory() -> void:
	print("Updating inventory...")
	if inventory == null:
		return


	print("Updating inventory...123")
	for i in range(Global.inventory.size()):
		var item = Global.inventory[i]
		if item != null:
			item_slot[i].icon_path = item.icon
			item_slot[i].amount = item.amount
