extends CharacterBody2D
class_name Player

@export_category("Variables")
@export var speed := 70.0

@export_category("Objects")
@export var animated_body: AnimatedSprite2D
@export var hand: Node2D

@onready var interact_ui := $InteractUI

var can_move: bool = false

func _ready() -> void:
	# For sure variable not null
	animated_body = $AnimatedBody
	hand = $PlayerHand
	Global.set_player_node(self)

func player_movement():
	var direction := Input.get_vector(
		"ui_left",
		"ui_right",
		"ui_up",
		"ui_down"
	)
	var shift := Input.is_key_pressed(KEY_SHIFT)

	if direction:
		if shift:
			velocity.x = direction.x * speed
			velocity.y = direction.y * speed
		else:
			velocity.x = direction.x * speed * 0.5
			velocity.y = direction.y * speed * 0.5
	elif not can_move:
		# If not moving, stop the player
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)

func animate_player(delta: float) -> void:
	if can_move:
		return

	var shift := Input.is_key_pressed(KEY_SHIFT)
	var left_lick := Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	var right_lick := Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT)
	var animated_name: String = "Idle"

	if left_lick:
		animated_name = "Attack"
	elif right_lick:
		animated_name = "Axe"
	elif velocity == Vector2.ZERO:
		animated_name = "Idle"
	elif shift:
		animated_name = "Run"
	else:
		animated_name = "Walk"

	animated_body.play(animated_name)
	if ["Axe", "Attack"].find(animated_name) == -1:
		hand.animate_play(animated_name)
	else:
		# handle lock time movement
		can_move = true
		hand.animate_play(animated_name,
			true,
			func() -> void:
				can_move = false
		)
		return

	for sprite in [animated_body, hand]:
		if velocity.x > 0:
			sprite.scale.x = abs(sprite.scale.x)
		elif velocity.x < 0:
			sprite.scale.x = - abs(sprite.scale.x)
	
	move_and_collide(velocity * delta)

func hurt(damage: float) -> void:
	can_move = true
	animated_body.play("Hurt")
	hand.animate_play("Hurt",
		false,
		func() -> void:
			can_move = false
	)

func _physics_process(delta: float) -> void:
	player_movement()
	animate_player(delta)
