extends StaticBody2D

@export var level_length: float = 5640  # Length of the level
@onready var collision_shape: CollisionShape2D = $CollisionShape2D  # Reference to CollisionShape2D
@onready var sprite: Sprite2D = $Sprite2D  # Reference to the sprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Adjust the collision shape to match the level length
	var shape = collision_shape.shape
	if shape is RectangleShape2D:
		shape.extents.x = level_length
		shape.extents.y = 20  # Height of the floor collision

	# Adjust the sprite's scale or size to match the length
	sprite.scale.x = level_length / sprite.texture.get_size().x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
