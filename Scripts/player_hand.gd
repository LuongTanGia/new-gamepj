extends Node2D
class_name PlayerHand

var on_attacked: Callable
var attack: bool = false

func _ready() -> void:
	$Area2D/CollisionShape2D.disabled = true

func _physics_process(delta: float) -> void:
	if $AnimatedSprite2D.frame >= 5:
		$Area2D/CollisionShape2D.disabled = !attack
	else:
		$Area2D/CollisionShape2D.disabled = true

func animate_play(animation: String, is_attack: bool = false, callback: Callable = Callable()) -> void:
	$AnimatedSprite2D.play(animation)
	if callback.is_custom():
		on_attacked = callback
	attack = is_attack


func _on_animated_sprite_2d_animation_finished() -> void:
	$AnimatedSprite2D.frame = 0
	if on_attacked.is_custom():
		on_attacked.call()
	attack = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Enemies":
		body.hurt(10)
