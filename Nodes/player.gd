extends CharacterBody2D

@export var max_speed: float = 80.0
@export var acceleration: float = 600.0
@export var friction: float = 800.0

var last_input_dir: Vector2 = Vector2.DOWN

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING

func _physics_process(delta: float) -> void:
	var input_dir := Input.get_vector("left", "right", "up", "down")

	if input_dir != Vector2.ZERO:
		last_input_dir = input_dir
		velocity = velocity.move_toward(input_dir * max_speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

	move_and_slide()
	update_animation(input_dir)

func update_animation(input_dir: Vector2) -> void:
	if input_dir != Vector2.ZERO:
		if abs(input_dir.x) > abs(input_dir.y):
			animated_sprite.play("walk_side")
			animated_sprite.flip_h = input_dir.x < 0
		elif input_dir.y < 0:
			animated_sprite.play("walk_up")
			animated_sprite.flip_h = false
		else:
			animated_sprite.play("walk_down")
			animated_sprite.flip_h = false
	else:
		if abs(last_input_dir.x) > abs(last_input_dir.y):
			animated_sprite.play("idle_side")
			animated_sprite.flip_h = last_input_dir.x < 0
		elif last_input_dir.y < 0:
			animated_sprite.play("idle_up")
			animated_sprite.flip_h = false
		else:
			animated_sprite.play("idle_down")
			animated_sprite.flip_h = false
