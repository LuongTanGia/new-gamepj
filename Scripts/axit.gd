extends Area2D

@export_category("Variables")
@export var dame: float = 10.0

var bodys: Node2D = null
var timer: float = 0.0

func _physics_process(delta: float) -> void:
	timer += delta
	if bodys != null and timer > 0.5:
		bodys.hurt(10)
		timer = 0.0

func _on_body_entered(body: Node2D) -> void:
	print("Body entered: ", body.name)
	if body.name == "Player":
		print("Player entered the area")
		bodys = body

func _on_body_exited(body: Node2D) -> void:
	print("Body exited: ", body.name)
	if body.name == "Player":
		print("Player exited the area")
		bodys = null
		timer = 0.0
