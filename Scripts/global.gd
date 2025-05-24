extends Node

var inventory: Array[CItem] = []
const MAX_INVENTORY_SIZE: int = 50

signal inventory_changed

# var player_node: Node2D

func _ready() -> void:
	# Initialize the inventory
	inventory.resize(MAX_INVENTORY_SIZE)
	# player_node = get_parent().get_node("Main/Player")

func add_item(item: CItem) -> bool:
	var item_index: int = get_item_index(item)

	if item_index == -1 and get_first_null_index() == -1:
		# Inventory is full
		return false
	elif item_index == -1:
		# Find the first null index to add the item
		inventory[get_first_null_index()] = item
		inventory_changed.emit()
	else:
		inventory[item_index].amount += item.amount

	inventory_changed.emit()

	return true

func remove_item(item: CItem) -> void:
	if item in inventory:
		inventory.erase(item)
		inventory_changed.emit()

func increase_item_amount(item: CItem, amount: int) -> void:
	if item in inventory:
		item.amount += amount
		inventory_changed.emit()

func set_player_node(node: Node2D) -> void:
	# player_node = node
	pass

func get_item_index(item) -> int:
	return inventory.find_custom(
			func(i) -> bool:
				if i == null:
					return false
				return i.item_name == item.item_name
	)

func get_first_null_index() -> int:
	for i in range(inventory.size()):
		if inventory[i] == null:
			return i
	return -1
