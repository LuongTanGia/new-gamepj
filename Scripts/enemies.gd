extends CharacterBody2D
class_name Enemies

var can_move: bool = false

func _physics_process(delta: float) -> void:
	if can_move:
		return
	
	$AnimatedSprite2D.play("Idle")

func hurt(damage: float) -> void:
	$AnimatedSprite2D.play("Hurt")
	can_move = true


func _on_animated_sprite_2d_animation_finished() -> void:
	can_move = true
	$AnimatedSprite2D.play("Idle")


func _on_area_2d_area_entered(area: Area2D) -> void:
	var body: Node2D = area.get_parent()
	if body.name == "PlayerHand" and body.attack:
		$AnimatedSprite2D.play("Attack")
		hurt(10)
