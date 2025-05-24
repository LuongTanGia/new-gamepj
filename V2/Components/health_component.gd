extends Node2D
class_name HealthComponent

@export var max_health := 100.0
var health: float

func _ready() -> void:
	health = max_health

func take_damage(amount: float) -> void:
	health -= amount
	if health <= 0:
		get_parent().queue_free()