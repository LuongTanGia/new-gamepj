extends CharacterBody2D
class_name PlayerV2

@export_category("Variables")
@export var speed := 70.0
@export_enum(
	"bowl_hair",
	"curly_hair",
	"long_hair",
	# "mop_hair",
	# "short_hair",
	# "spikey_hair",
	) var style_hair: String = "bowl_hair"

@onready var animated_body: AnimatedSprite2D = $AnimatedBody
@onready var animated_hand: AnimatedSprite2D = $AnimatedHand
@onready var animated_hair: AnimatedSprite2D = $AnimatedHair

const IDLE_ANIMATION: String = "Idle"
var can_move: bool = false

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	load_hair()

func load_hair() -> void:
	var path := animated_hair.sprite_frames.get_path().replace("res://", "")
	var pathAr := path.split("/")
	pathAr.remove_at(pathAr.size() - 1)
	path = ("res://" +
		"/".join(PackedStringArray(pathAr)) +
		"/" + style_hair +
		"_player.tres"
	)
	animated_hair.sprite_frames = load(path)

func player_movement(delta: float) -> void:
	var shift := Input.is_key_pressed(KEY_SHIFT)
	var direction := Input.get_vector(
		"ui_left",
		"ui_right",
		"ui_up",
		"ui_down"
	)

	if direction:
		velocity = direction * speed
		if !shift:
			velocity *= 0.5
	else:
		velocity = Vector2(
			move_toward(velocity.x, 0, speed),
			move_toward(velocity.x, 0, speed)
		)

	move_and_collide(velocity * delta)

func animate_player() -> void:
	if can_move:
		return

	var shift := Input.is_key_pressed(KEY_SHIFT)
	var animated_name := IDLE_ANIMATION

	if velocity == Vector2.ZERO:
		animated_name = "Idle"
	elif shift:
		animated_name = "Run"
	else:
		animated_name = "Walk"

	for sprite: AnimatedSprite2D in [
		animated_body,
		animated_hand,
		animated_hair
	]:
		sprite.play(animated_name)
		if velocity.x > 0:
			sprite.flip_h = false
		elif velocity.x < 0:
			sprite.flip_h = true

func _physics_process(delta: float) -> void:
	player_movement(delta)
	animate_player()
