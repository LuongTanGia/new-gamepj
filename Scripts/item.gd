@tool
extends Node2D
class_name Item

@export var item_name: String
@export var description: String
@export var damage: int = 10
@export var amount: int = 1
@export var icon: Texture2D
@export var type: String

var screenPath := 'res://Screens/item.tscn'

@onready var sprite := $Sprite2D
var in_hitbox: bool = false

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	if icon:
		sprite.texture = icon

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		sprite.texture = icon
		return
	if icon:
		sprite.texture = icon

	var key_f := Input.is_action_pressed("ui_pickup")

	if key_f and in_hitbox:
		pickup()

func pickup() -> void:
	var item = CItem.new()
	item.name = item_name
	item.description = description
	item.damage = damage
	item.amount = amount
	item.icon = icon
	item.type = type
	
	Global.add_item(item)
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Item hitbox entered by: ", body.name)
	if body.is_in_group("PLayerG") or body.name == "Player":
		in_hitbox = true
		if body.has_node("interact_ui"):
			body.interact_ui.show()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("PLayerG") or body.name == "Player":
		in_hitbox = false
		if body.has_node("interact_ui"):
			body.interact_ui.show()
