extends CharacterBody2D


const SPEED: float = 300.0
const JUMP_VELOCITY: float = -400.0
const MAX_JUMPS: int = 1

var jumps_remaining: int = 0
var screen_size: Vector2
@onready var camera: Camera2D = $Camera2D

func _ready() -> void:
	camera.make_current()
	jumps_remaining = MAX_JUMPS
	screen_size = get_viewport_rect().size

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and jumps_remaining > 0:
		velocity.y = JUMP_VELOCITY
		jumps_remaining -= 1  # Use up one jump
	
	# Reset jumps when on the floor
	if is_on_floor():
		jumps_remaining = MAX_JUMPS

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.flip_h = direction < 0  # Flip sprite when moving left
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	# Prevent the player from moving left beyond the starting point
	if position.x < -640:
		position.x = -640
