extends Node2D

@export var platform_scene: PackedScene  # Drag your Platform.tscn here
@export var spawn_area: Rect2 = Rect2(Vector2.ZERO, Vector2(5000, 100))  # Define spawn area
@export var ground_offset: int = 300  # Offset above the ground
@export var level_height: int = 720  # Level height (adjust if different)
@export var platform_count: int = 150  # Number of platforms to spawn
@export var max_attempts: int = 10  # Max attempts to place a platform without overlap
@export var min_separation: float = 150.0  # Minimum space between platforms

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Set spawn area dynamically based on viewport and offsets
	var ground_y = level_height - ground_offset
	spawn_area = Rect2(
		Vector2(0, ground_y),  # Start at (0, ground_y)
		Vector2(5000, -ground_y)  # Width is 1280, height is from ground to top
	)
	
	for i in range(platform_count):
		spawn_platform()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_platform() -> void:
	var attempts = 0
	var valid_position_found = false
	var platform: Node2D
	
	while attempts < max_attempts and not valid_position_found:
		# Create an instance of the platform scene
		platform = platform_scene.instantiate()

		# Generate a random position within the spawn area
		var random_x = randf_range(spawn_area.position.x, spawn_area.position.x + spawn_area.size.x)
		var random_y = randf_range(spawn_area.position.y, spawn_area.position.y + spawn_area.size.y)
		platform.position = Vector2(random_x,random_y)
				
		# Check for overlap with existing platforms
		if not is_overlapping(platform):
			valid_position_found = true  # Position is valid, no overlap detected
		
		attempts += 1
	
	if valid_position_found:
		# Add the platform instance to the scene
		add_child(platform)
	else:
		print("Could not place platform after", max_attempts, "attempts.")

func is_overlapping(platform: Node2D) -> bool:
	# Get the new platform's global bounding box
	var new_position = platform.global_position
	
	# Check against all children in the scene
	for child in get_children():
		if child.has_node("CollisionShape2D") and child != platform:
			var existing_position = child.position

			## Check if the rectangles overlap
			#if new_position.position.x < existing_position.position.x + existing_position.size.x and new_position.position.x + new_position.size.x > existing_position.position.x and new_position.position.y < existing_position.position.y + existing_position.size.y and new_position.position.y + new_position.size.y > existing_position.position.y:
				#return true  # Overlap detected\
				
			# Check the distance between the two platforms
			if new_position.distance_to(existing_position) < min_separation:
				return true  # Too close


	return false  # No overlap detected

#func get_global_aabb(node: Node2D) -> Rect2:
	## Get the CollisionShape2D from the node
	#var collision_shape = node.get_node("CollisionShape2D")
	#var shape = collision_shape.shape
	#if shape and shape is RectangleShape2D:
		#var rect = shape.extents * 2  # Get size from extents
		#var global_position = node.global_position
		#return Rect2(global_position - rect / 2, rect)  # Return the global AABB
	#return Rect2()
	
#func _draw():
	#draw_rect(spawn_area, Color(1, 0, 0, 0.5))  # Draw red rectangle to visualize spawn area
