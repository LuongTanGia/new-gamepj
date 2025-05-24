extends NinePatchRect
class_name Inventory

var item_slot: Array = [ItemSlotV2]

func _ready() -> void:
	visible = false
	item_slot = $GridContainer.get_children() as Array
	Global.inventory_changed.connect(update)
	update()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_inventory"):
		visible = !visible

func update() -> void:
	for i in range(Global.inventory.size()):
		item_slot[i].update(Global.inventory[i])
