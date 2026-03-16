
extends CharacterBody2D

@export var max_speed: float = 80.0
@export var acceleration: float = 600.0
@export var friction: float = 800.0

var last_input_dir: Vector2 = Vector2.DOWN

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
