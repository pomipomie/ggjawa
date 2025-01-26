extends Sprite2D

@export var platform_textures: Array[Resource]  # Array to hold different textures for the platform
@onready var collision_shape: CollisionShape2D = $Platform/CollisionShape2D  # Reference to CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if platform_textures.size() > 0:
		var random_texture = platform_textures[randi() % platform_textures.size()]
		
		 # Assign the random texture to the Sprite2D
		texture = random_texture  # Set a random texture from the list
		
		# Adjust the CollisionShape2D to match the texture width and height
		if collision_shape:
			adjust_collision_shape()
		else:
			print("Error: CollisionShape2D not found!")
		
# Function to adjust the collision shape size based on the sprite's texture
func adjust_collision_shape():
	if texture:
		var texture_size = texture.get_size()  # Get the texture size (width, height)
		
		# Assuming a RectangleShape2D is used for the collision shape
		var shape = collision_shape.shape
		if shape is RectangleShape2D:
			shape.extents = Vector2(texture_size.x / 2, texture_size.y / 2)  # Set extents to half the texture width/height

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
