@tool
extends Button
class_name ItemSlot

@export var hot_bar_index: int = -1
@export var icon_path: Texture2D = null
@export var amount: int = 0

@onready var icon_node: TextureRect = $MarginContainer/TextureRect
@onready var hot_bar_index_node: Label = $Hotkey/Label
@onready var amount_node: Label = $Amount/Label

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	update()

func _process(_delta: float) -> void:
	update()

func update() -> void:
	# Set the icon texture
	if icon_path != null:
		icon_node.texture = icon_path

	# Set the hot bar index
	if hot_bar_index != -1:
		hot_bar_index_node.set_deferred("text", str(hot_bar_index))
	else:
		hot_bar_index_node.set_deferred("text", "")
	
	if amount > 1:
		amount_node.set_deferred("text", str(amount))
	else:
		amount_node.set_deferred("text", "")
