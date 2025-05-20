extends Area2D

@export_category("Variables")
@export var dame: float = 10.0

var current_body: Node2D = null
var timer: float = 0.0

func _physics_process(delta: float) -> void:
	timer += delta
	if current_body != null and timer > 0.5:
		current_body.hurt(10)
		timer = 0.0

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		current_body = body

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		current_body = null
		timer = 0.0
