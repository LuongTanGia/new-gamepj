extends Area2D

@export_category("Variables")
@export var dame: float = 10.0

var current_body: Node2D = null
var timer: float = 0.0

func _physics_process(delta: float) -> void:
	timer += delta
	if current_body != null and timer > 0.5:
		current_body.hurt(dame)
		timer = 0.0

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		current_body = body

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		current_body = null
		timer = 0.0

func _on_area_entered(area: Area2D) -> void:
	if area.get_groups().find("PlayerHitBox") != -1:
		current_body = area.get_parent()

func _on_area_exited(area: Area2D) -> void:
	if area.get_groups().find("PlayerHitBox") != -1:
		current_body = null
		timer = 0.0
