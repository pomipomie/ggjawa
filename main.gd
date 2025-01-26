extends Node2D

@export var level_length: float = 5640  # Length of the level in pixels
@export var end_marker_scene: PackedScene  # Drag and drop your EndMarker.tscn here
@export var end_marker_offset: float = 50  # Offset from the end of the level
@export var spawn_bubble_bad_scene: PackedScene
@export var spawn_bubble_good_scene: PackedScene

var spawn_bubble_bad_instance: Node2D
var spawn_bubble_good_instance: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#if spawn_bubble_bad_scene:
		#spawn_bubble_bad_instance = spawn_bubble_bad_scene.instantiate()
		#add_child(spawn_bubble_bad_instance)
		#spawn_bubble_bad_instance.start_spawning()  # Call the start function to initialize spawning
	#else:
		#print("Error: spawn_bubble_bad_scene not assigned!")
	#
	#if spawn_bubble_good_scene:
		#spawn_bubble_good_instance = spawn_bubble_good_scene.instantiate()
		#get_parent().add_child(spawn_bubble_good_instance)
		#spawn_bubble_good_instance.start_spawning()  # Call the start function to initialize spawning
	#else:
		#print("Error: spawn_bubble_bad_scene not assigned!")
		
		
	# Spawn the end marker at the end of the level
	spawn_end_marker()

func spawn_end_marker():
	# Instance the end marker object
	var end_marker = end_marker_scene.instantiate()
	
	# Position the end marker at the end of the level with an optional offset
	end_marker.position = Vector2(level_length - end_marker_offset, 720 - 50)  # Adjust Y as needed for the floor height
	
	# Add it to the level
	add_child(end_marker)
	
	# Connect the signal
	end_marker.connect("level_completed", Callable(self, "_on_level_completed"))
	
	print("End marker position: ", end_marker.position)
	print("End marker parent: ", end_marker.get_parent())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_level_completed():
	print("Level Completed!")  # Add your end-level logic here
