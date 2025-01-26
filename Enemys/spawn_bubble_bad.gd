extends Area2D

@onready var bubble_scene = preload("res://Enemys/spawn_bubble_bad.tscn")

var bool_spawn = true
var random = RandomNumberGenerator.new()

func _ready():
	random.randomize()
	set_process(false)

func start_spawning():
	set_process(true)

func _process(_delta):
	spawn()

func spawn():
	#if bool_spawn and not Global.loss:
	if bool_spawn:
		$Timer.start()
		bool_spawn = false
		var bubble_instance = bubble_scene.instantiate()
		if bubble_instance == null:
			print("Error: Failed to instantiate bubble_scene!")
			return
		bubble_instance.position = Vector2(random.randi_range(0,5000),random.randi_range(-8,560))
		add_child(bubble_instance)
		print("Spawning bubble at: ", bubble_instance)

func _on_timer_timeout() -> void:
	bool_spawn = true
	pass
