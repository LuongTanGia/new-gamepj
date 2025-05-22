@tool
extends Node2D
class_name Item

@export var item_name: String
@export var type: String
@export var description: String
@export var icon: Texture2D
@export var animated: AnimatedSprite2D
@export var damage: int = 10
@export var amount: int = 1

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
		return
	if icon:
		sprite.texture = icon

	var key_f := Input.is_action_pressed("ui_pickup")

	if key_f and in_hitbox:
		pickup()

func pickup() -> void:
	var item = {
		"item_name": item_name,
		"type": type,
		"description": description,
		"icon": icon,
		"animated": animated,
		"damage": damage,
		"screenPath": screenPath,
		"amount": amount
	}
	if Global.player_node:
		Global.add_item(item)
		queue_free()
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		in_hitbox = true
		body.interact_ui.show()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		in_hitbox = false
		body.interact_ui.hide()
