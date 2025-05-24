@tool
extends NinePatchRect
class_name ItemSlotV2

@export_category("Item Variables")
@export var item_name: String = ""
@export var amount: int = 0
@export var icon: Texture2D = null

@export_category("Variables")
@export var hotkey: String = ""
@export var is_selected: bool = false

@onready var hotkey_node: Label = $Hotkey/Label
@onready var amount_node: Label = $Amount/Label
@onready var icon_node: TextureRect = $Sprite/TextureRect

const selected_texture = preload("res://Assets/UI/panel-1.png")
const unselected_texture = preload("res://Assets/UI/panel.png")

var item_info: CItem = null


func _ready() -> void:
	item_info = CItem.new()
	item_info.amount = amount
	item_info.icon = icon
	item_info.name = item_name
	on_change_item_info()

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		on_change_item_info()

func update(item: CItem) -> void:
	item_info = item
	on_change_item_info()

func on_change_item_info():
	if item_info != null:
		if item_info.hotkey != null:
			hotkey_node.text = item_info.hotkey

		if item_info.amount != null:
			amount_node.text = str(item_info.amount)
		
		if item_info.icon != null:
			icon_node.texture = item_info.icon
